local App = require('src.app')
local class = App.libs.middleclass
local GameServices = require('src.systems.game.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local GameGuiMsgService = GameServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local GameGuiURL = URL.gui_nodes.game_scene

local SUBSCRIPTION = 'PauseButtonView'

local PauseButtonView = class('PauseButtonView')

function PauseButtonView:initialize()
    self.click_observer = Observable:new()

    self.button = Button:new(GameGuiURL.pause_button, GUIButtonConfig, function()
        self.click_observer:next()
    end)

    GameGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button:on_click(action)
    end)
end

return PauseButtonView
