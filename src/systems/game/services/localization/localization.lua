local App = require('src.app')
local LocalizationCtrl = require('src.common.classes.localization_controller')
local MsgService = require('src.systems.game.services.msg.gui_msg')

local SCENE_URL = App.constants.urls.scenes.game_scene.main

local LocalizationService = LocalizationCtrl:new(SCENE_URL, MsgService)

return LocalizationService
