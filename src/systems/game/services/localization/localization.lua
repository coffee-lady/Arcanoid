local App = require('src.app')
local Localization = require('src.common.classes.localization')
local MsgService = require('src.systems.game.services.msg.gui_msg')

local Services = require('src.services.services')
local EnergyService = Services.energy

local SCENE_URL = App.constants.urls.scenes.game_scene.main

local LocalizationService = Localization:new(SCENE_URL, MsgService)

function LocalizationService:get_vars()
    return {
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy()
    }
end

return LocalizationService
