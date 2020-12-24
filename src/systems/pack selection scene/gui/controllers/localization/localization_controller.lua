local App = require('src.app')
local SceneServices = require('src.systems.pack selection scene.services.services')
local LocalizationCtrl = require('src.common.classes.localization_controller')
local MsgService = SceneServices.gui_msg

local SCENE = 'pack_selection_scene'

local URL = App.constants.urls
local TEXT_NODES = URL.gui_nodes[SCENE].text
local SCENE_URL = URL.scenes[SCENE].main

local LocalizationController = LocalizationCtrl:new(SCENE_URL, TEXT_NODES, MsgService)

return LocalizationController
