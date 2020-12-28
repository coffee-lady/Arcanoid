local App = require('src.app')
local LocalizationCtrl = require('src.common.classes.localization_controller')
local MsgService = require('src.systems.game losing popup.services.msg.gui_msg')

local SCENE_URL = App.constants.urls.scenes.game_losing_popup.main

local LocalizationController = LocalizationCtrl:new(SCENE_URL, MsgService)

return LocalizationController

