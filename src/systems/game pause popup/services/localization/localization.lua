local App = require('src.app')
local Common = require('src.common.common')
local Localization = Common.classes.localization

local MsgService = require('src.systems.game pause popup.services.msg.gui_msg')

local SCENE_URL = App.constants.urls.scenes.game_pause_popup.main

local LocalizationController = Localization:new(SCENE_URL, MsgService)

return LocalizationController
