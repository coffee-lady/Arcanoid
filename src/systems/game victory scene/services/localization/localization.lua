local App = require('src.app')
local Services = require('src.services.services')
local LocalizationCtrl = require('src.common.classes.localization_controller')

local MsgService = require('src.systems.game victory scene.services.msg.gui_msg')
local LevelService = Services.level

local SCENE_URL = App.constants.urls.scenes.game_victory_scene.main

local next_level = LevelService:get_current_level()
local next_pack = LevelService:get_current_pack()

local LocalizationController = LocalizationCtrl:new(SCENE_URL, MsgService, {
    next_level = next_level,
    next_pack = next_pack.title
})

return LocalizationController
