local App = require('src.app')
local LocalStorage = require('src.services.local_storage.local_storage')

local Observable = App.libs.event_observation.observable
local EnergyConfig = App.config.game.go.energy

local MSG = App.constants.messages
local ENERGY = 'energy'

local CURRENT = 'current'
local TIMER = 'timer'

local EnergyService = {}

local function notify(self)
    for i = 1, #self.listeners do
        msg.post(self.listeners[i], MSG.common.energy_updated)
    end
end

local function set_infinite_timer(self)
    LocalStorage:set(ENERGY, TIMER, os.time() + EnergyConfig.recovery_time)

    self.current_timer = timer.delay(EnergyConfig.recovery_time, true, function(_, handle)
        self:increase(EnergyConfig.recovery_count)

        if self.current_energy >= EnergyConfig.max_count then
            LocalStorage:set(ENERGY, TIMER, nil)
            timer.cancel(handle)
            self.current_timer = nil
            return
        end

        LocalStorage:set(ENERGY, TIMER, os.time() + EnergyConfig.recovery_time)
    end)
end

local function check_timer(self)
    if self.current_energy < EnergyConfig.max_count and not LocalStorage:get(ENERGY, TIMER) then
        set_infinite_timer(self)
    end
end

function EnergyService:init()
    self.current_energy = LocalStorage:get(ENERGY, CURRENT)
    self.update_observer = Observable:new()
    self.listeners = {}

    if not self.current_energy then
        self.current_energy = EnergyConfig.max_count
        LocalStorage:set(ENERGY, CURRENT, EnergyConfig.max_count)

        return
    end

    local planned_timer = LocalStorage:get(ENERGY, TIMER)

    if not planned_timer then
        if self.current_energy < EnergyConfig.max_count then
            set_infinite_timer(self)
        end

        return
    end

    local time_left = os.difftime(planned_timer, os.time())

    if time_left > 0 then
        self.current_timer = timer.delay(time_left, false, function()
            self:increase(EnergyConfig.recovery_count)

            LocalStorage:set(ENERGY, TIMER, nil)
            self.current_timer = nil

            check_timer(self)
        end)

        return
    end

    local times_timer_expired = math.floor(-time_left / EnergyConfig.recovery_time)

    if times_timer_expired > 0 then
        local bonus = math.floor((EnergyConfig.max_count - self.current_energy) / times_timer_expired)

        if bonus > 0 then
            self:increase(bonus)
        end
    end

    set_infinite_timer(self)
end

function EnergyService:add_listener(url)
    self.listeners[#self.listeners + 1] = url
end

function EnergyService:remove_listener(url)
    for i = 1, #self.listeners do
        if self.listeners[i] == url then
            table.remove(self.listeners, i)
            break
        end
    end
end

function EnergyService:increase(count)
    self.current_energy = self.current_energy + count
    LocalStorage:set(ENERGY, CURRENT, self.current_energy)

    notify(self)

    if self.current_energy >= EnergyConfig.max_count and self.current_timer then
        LocalStorage:set(ENERGY, TIMER, nil)
        self.current_timer = nil
    end
end

function EnergyService:decrease(count)
    local new_energy = self.current_energy - count

    if new_energy < 0 then
        return false
    end

    self.current_energy = new_energy
    LocalStorage:set(ENERGY, CURRENT, self.current_energy)

    notify(self)

    check_timer(self)

    return true
end

function EnergyService:is_enough_to_buy_life()
    return self.current_energy - EnergyConfig.life_cost >= 0
end

function EnergyService:is_enough_to_restart()
    return self.current_energy - EnergyConfig.restart_cost >= 0
end

function EnergyService:buy_life()
    return self:decrease(EnergyConfig.life_cost)
end

function EnergyService:restart_level()
    return self:decrease(EnergyConfig.restart_cost)
end

function EnergyService:win_level()
    self:increase(EnergyConfig.level_reward)
end

function EnergyService:get_current_energy()
    return self.current_energy
end

function EnergyService:get_max_energy()
    return EnergyConfig.max_count
end

function EnergyService:get_life_cost()
    return EnergyConfig.life_cost
end

function EnergyService:get_minutes_left()
    local planned_timer = LocalStorage:get(ENERGY, TIMER)

    if not planned_timer then
        return 0
    end

    local seconds_left = os.difftime(planned_timer, os.time())

    if seconds_left < 0 then
        return 0
    end

    local SEC_IN_MIN = 60
    return math.floor(seconds_left / SEC_IN_MIN)
end

return EnergyService
