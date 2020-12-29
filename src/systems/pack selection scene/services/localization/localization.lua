local App = require('src.app')
local LocalizationCtrl = require('src.common.classes.localization_controller')
local Services = require('src.services.services')
local MsgService = require('src.systems.pack selection scene.services.msg.gui_msg_service')

local LevelService = Services.level

local SCENE_URL = App.constants.urls.scenes.pack_selection_scene.main

local LocalizationService = LocalizationCtrl:new(SCENE_URL, MsgService)

function LocalizationService:get_vars()
    return {
        current_level = LevelService:get_progress_level(),
        current_pack = LevelService:get_current_pack().title
    }
end

return LocalizationService
