local App = require('src.app')
local Services = require('src.services.services')
local Models = require('src.systems.pack selection scene.gui.models.models')
local Views = require('src.systems.pack selection scene.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls

local BottomPanel = Models.bottom_panel
local BottomPanelView = Views.bottom_panel

local BottomPanelController = {}

function BottomPanelController:init()
    self.bottom_panel = BottomPanel:new()
    self.bottom_panel_view = BottomPanelView:new(self.bottom_panel.progress_level, self.bottom_panel.current_pack)

    self.bottom_panel_view.continue_game_observer:subscribe(function()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main, {
            continue = true
        })
    end)
end

function BottomPanelController:final()
    self.bottom_panel_view:final()
end

return BottomPanelController
