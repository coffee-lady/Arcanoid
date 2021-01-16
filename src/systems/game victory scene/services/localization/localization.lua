local App = require('src.app')
local Services = require('src.services.services')
local Common = require('src.common.common')
local Localization = Common.classes.localization

local MsgService = require('src.systems.game victory scene.services.msg.gui_msg')
local LevelService = Services.level
local EnergyService = Services.energy
local MSG = App.constants.messages

local SCENE_URL = App.constants.urls.scenes.game_victory_scene.main
local ENERGY_CONTAINER = App.constants.urls.gui_nodes.game_victory_scene.text.energy_container_left

local SECOND = 1
local subs

local LocalizationService = Localization:new(SCENE_URL, MsgService, {
    init = function(self)
        subs = MsgService:on(SCENE_URL, MSG.common.energy_updated, function()
            self:update()
        end)

        timer.delay(SECOND, true, function()
            self:update()
        end)
    end,
    final = function()

        subs:unsubscribe()
    end
})

function LocalizationService:get_vars()
    local min_left, sec_left = EnergyService:get_time_left()

    if min_left == 0 and sec_left == 0 then
        self:remove(ENERGY_CONTAINER)
    end

    return {
        next_level = LevelService:get_current_level(),
        next_pack = LevelService:get_current_pack().title,
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy(),
        min_left = min_left < 10 and '0' .. min_left or min_left,
        sec_left = sec_left < 10 and '0' .. sec_left or sec_left
    }
end

return LocalizationService
