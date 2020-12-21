local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game pause popup.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls
local GameMSG = App.constants.messages.game
local GAME_SCENE_URL = URL.scenes.game_scene.main
local START_SCENE_URL = URL.scenes.start_scene.main

local OverallView = Views.overall

local PopupController = {}

function PopupController:init()
    self.overall_view = OverallView:new()

    self.overall_view.continue_observer:subscribe(function()
        ScenesService:post(GAME_SCENE_URL, GameMSG.continue)
        ScenesService:back_to_prev_scene()
    end)

    self.overall_view.restart_observer:subscribe(function()
        ScenesService:post(GAME_SCENE_URL, GameMSG.restart)
        ScenesService:back_to_prev_scene()
    end)

    self.overall_view.back_observer:subscribe(function()
        ScenesService:switch_to_scene(START_SCENE_URL)
    end)
end

function PopupController:final()
    self.overall_view:final()
end

return PopupController
