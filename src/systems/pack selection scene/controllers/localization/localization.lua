local App = require('src.app')
local SceneServices = require('src.systems.pack selection scene.services.services')
local Localization = require('src.common.classes.localization')
local Services = require('src.services.services')
local MsgService = SceneServices.gui_msg

local LevelService = Services.level

local SCENE_URL = App.constants.urls.scenes.pack_selection_scene.main

local current_level = LevelService:get_progress_level()
local current_pack = LevelService:get_current_pack()

local LocalizationController = Localization:new(SCENE_URL, MsgService, {
    current_level = current_level,
    current_pack = current_pack.title
})

return LocalizationController
