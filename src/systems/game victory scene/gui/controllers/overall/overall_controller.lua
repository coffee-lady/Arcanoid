local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game victory scene.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls
local GAME_SCENE_URL = URL.scenes.game_scene.main
local START_SCENE_URL = URL.scenes.start_scene.main

local OverallView = Views.overall

local SceneController = {}

function SceneController:init()
    self.overall_view = OverallView:new()

    self.overall_view.next_observer:subscribe(function()
        ScenesService:switch_to_scene(GAME_SCENE_URL)
    end)

    self.overall_view.back_observer:subscribe(function()
        ScenesService:switch_to_scene(START_SCENE_URL)
    end)
end

function SceneController:final()
    self.overall_view:final()
end

return SceneController
