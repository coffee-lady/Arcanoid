local App = require('src.app')
local LocalizationCtrl = require('src.common.classes.localization_controller')
local MsgService = require('src.systems.start scene.services.msg.gui_msg_service')

local SCENE_URL = App.constants.urls.scenes.start_scene.main

local LocalizationController = LocalizationCtrl:new(SCENE_URL, MsgService)

return LocalizationController
