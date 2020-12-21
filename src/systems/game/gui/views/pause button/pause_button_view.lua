local App = require('src.app')
local class = App.libs.middleclass
local GameServices = require('src.systems.game.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local GameGuiMsgService = GameServices.gui_msg

local GUIButtonConfig = App.config.game.gui.pause_button
local Actions = App.constants.actions
local URL = App.constants.urls
local GameGuiURL = URL.gui_nodes.game_scene

local SUBSCRIPTION = 'PauseButtonView'

local PauseButtonView = class('PauseButtonView')

local function set_btn_animation(button)
    local blackout = GUIButtonConfig.blackout
    local scale = GUIButtonConfig.scale
    local duration = GUIButtonConfig.duration
    local easing = GUIButtonConfig.easing

    button:animate_click(blackout, scale, duration, easing)
end

function PauseButtonView:initialize()
    self.click_observer = Observable:new()

    self.button = Button:new(gui.get_node(GameGuiURL.pause_button), function()
        self.click_observer:next()
    end)

    set_btn_animation(self.button)

    GameGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button:on_click(action)
    end)
end

return PauseButtonView
