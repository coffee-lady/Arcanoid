local App = require('src.app')
local class = App.libs.middleclass
local SceneServices = require('src.systems.pack selection scene.services.services')
local SubViews = require('src.systems.pack selection scene.gui.views.bottom panel.subviews.subviews')
local Observable = App.libs.event_observation.observable

local SceneGuiMsgService = SceneServices.gui_msg

local Actions = App.constants.actions
local URL = App.constants.urls
local SceneGuiURLs = URL.gui_nodes.pack_selection_scene

local PackView = SubViews.pack
local LevelView = SubViews.level

local SUBSCRIPTION = 'BottomPanelView'

local BottomPanelView = class('BottomPanelView')

function BottomPanelView:initialize(current_level, current_pack)
    self.panel_node = gui.get_node(SceneGuiURLs.bottom_panel)
    self.continue_game_observer = Observable:new()

    PackView:new(current_pack)
    LevelView:new(current_level)

    SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        if gui.pick_node(self.panel_node, action.x, action.y) then
            self.continue_game_observer:next()
        end
    end)
end

function BottomPanelView:final()
    self.continue_game_observer:complete()
end

return BottomPanelView
