local App = require('src.app')
local Services = require('src.services.services')
local Localization = require('src.common.classes.localization')

local MsgService = require('src.systems.game victory scene.services.msg.gui_msg')
local LevelService = Services.level
local EnergyService = Services.energy

local SCENE_URL = App.constants.urls.scenes.game_victory_scene.main

local LocalizationService = Localization:new(SCENE_URL, MsgService)

function LocalizationService:get_vars()
    return {
        next_level = LevelService:get_current_level(),
        next_pack = LevelService:get_current_pack().title,
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy(),
        energy_recovery_left_time = EnergyService:get_minutes_left()
    }
end

return LocalizationService
