local App = require('src.app')

local Observable = App.libs.event_observation.observable
local AutosaveIntervalTimer = App.libs.AutosaveIntervalTimer

local EnergyConfig = App.config.game.energy
local MSG = App.constants.messages
local ENERGY = 'energy'
local CURRENT = 'current'
local TIMER = 'timer'

local EnergyService = class('EnergyService')

EnergyService.__cparams = {'player_data_storage'}

function EnergyService:initialize(player_data_storage)
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage

    self.current_energy = self.player_data_storage:get(ENERGY, CURRENT) or EnergyConfig.max_count

    self:_set_timer()
    self:_update_bonus_for_expired_time()
end

function EnergyService:_set_timer()
    self.timer = AutosaveIntervalTimer(EnergyConfig.recovery_time, function()
        self:change_count(EnergyConfig.recovery_count)

        if self.current_energy >= EnergyConfig.max_count then
            self.timer:cancel()
            self.timer = nil
        end
    end)

    self.timer:enable_saving(ENERGY, TIMER)
end

function EnergyService:_update_bonus_for_expired_time()
    local times_timer_expired = self.timer:get_times_expired()

    if times_timer_expired > 0 then
        local bonus = math.floor((EnergyConfig.max_count - self.current_energy) / times_timer_expired)

        if bonus > 0 then
            self:increase(bonus)
        end
    end
end

function EnergyService:_check_timer()
    if not self.timer and self.current_energy < EnergyConfig.max_count then
        self:_set_timer()
    end
end

function EnergyService:change_count(delta_count)
    local energy_count = self.current_energy + delta_count

    self.current_energy = energy_count
    self.player_data_storage:set(ENERGY, CURRENT, self.current_energy)

    if self.current_energy >= EnergyConfig.max_count and self.current_timer then
        self.player_data_storage:set(ENERGY, TIMER, nil)
        self.current_timer = nil
    else
        self:_check_timer()
    end
end

function EnergyService:can_change_count(delta_count)
    return self.current_energy + delta_count >= 0
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

function EnergyService:get_level_reward()
    return EnergyConfig.level_reward
end

function EnergyService:get_time_left()
    return self.timer:get_seconds_left()
end

return EnergyService
