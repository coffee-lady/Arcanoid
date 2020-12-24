local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.start scene.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls
local PACK_SELECTION_SCENE_URL = URL.scenes.pack_selection_scene.main

local OverallView = Views.overall

local OverallController = {}

function OverallController:init()
    self.overall_view = OverallView:new()

    self.overall_view.play_game_observer:subscribe(function()
        ScenesService:switch_to_scene(PACK_SELECTION_SCENE_URL)
    end)
end

function OverallController:final()
    self.overall_view:final()
end

return OverallController
