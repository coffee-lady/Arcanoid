local App = require('src.app')
local class = App.libs.middleclass
local GameServices = require('src.systems.game.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local SceneGuiMsgService = GameServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local GameGuiURL = URL.gui_nodes.game_scene

local SUBSCRIPTION = 'OverallView'

local OverallView = class('OverallView')

function OverallView:initialize()
    self.pause_observer = Observable:new()

    self.pause_button = Button:new(GameGuiURL.pause_button, GUIButtonConfig, function()
        self.pause_observer:next()
    end)

    SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.pause_button:on_click(action)
    end)
end

function OverallView:final()
    self.pause_observer:complete()
end

return OverallView
