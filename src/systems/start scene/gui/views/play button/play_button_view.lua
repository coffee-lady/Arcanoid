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

local SUBSCRIPTION = 'PlayButtonView'

local PlayButtonView = class('PlayButtonView')

function PlayButtonView:initialize()
    self.click_observer = Observable:new()

    self.button = Button:new(SceneGuiURL.button_play, GUIButtonConfig, function()
        self.click_observer:next()
    end)

    SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button:on_click(action)
    end)
end

function PlayButtonView:final()
    self.click_observer:complete()
end

return PlayButtonView
