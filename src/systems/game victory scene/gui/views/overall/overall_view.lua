local App = require('src.app')
local class = App.libs.middleclass
local SceneServices = require('src.systems.game victory scene.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local SceneGuiMsgService = SceneServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local SceneGuiURL = URL.gui_nodes.game_victory_scene

local SUBSCRIPTION = 'SceneView'

local SceneView = class('SceneView')

local function create_buttons(self)
    self.button_next = Button:new(SceneGuiURL.button_next, GUIButtonConfig, function()
        self.next_observer:next()
    end)

    self.button_back = Button:new(SceneGuiURL.button_back, GUIButtonConfig, function()
        self.back_observer:next()
    end)

    SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button_next:on_click(action)
        self.button_back:on_click(action)
    end)
end

function SceneView:initialize()
    self.next_observer = Observable:new()
    self.back_observer = Observable:new()

    create_buttons(self)
end

function SceneView:final()
    self.next_observer:complete()
    self.back_observer:complete()
end

return SceneView
