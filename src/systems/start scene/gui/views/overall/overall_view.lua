local App = require('src.app')
local class = App.libs.middleclass
local SceneServices = require('src.systems.start scene.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local SceneGuiMsgService = SceneServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local SceneGuiURL = URL.gui_nodes.start_scene

local SUBSCRIPTION = 'OverallView'

local OverallView = class('OverallView')

function OverallView:initialize()
    self.play_game_observer = Observable:new()

    self.play_button = Button:new(SceneGuiURL.button_play, GUIButtonConfig, function()
        self.play_game_observer:next()
    end)

    SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.play_button:on_click(action)
    end)
end

function OverallView:final()
    self.play_game_observer:complete()
end

return OverallView
