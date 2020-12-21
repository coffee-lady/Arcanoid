local App = require('src.app')
local class = App.libs.middleclass
local GameServices = require('src.systems.game.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local GameGuiMsgService = GameServices.gui_msg

local Config = App.config
local Actions = App.constants.actions
local GameURL = App.constants.urls.gui_nodes.game_scene

local GUIButtonConfig = Config.game.gui.pause_button

local SUBSCRIPTION = 'PauseButtonView'

local blackout = GUIButtonConfig.blackout
local scale = GUIButtonConfig.scale
local duration = GUIButtonConfig.duration
local easing = GUIButtonConfig.easing

local PauseButtonView = class('PauseButtonView')

function PauseButtonView:initialize()
    self.click_observer = Observable:new()

    self.button = Button:new(gui.get_node(GameURL.pause_button), function()
        self.click_observer:next()
    end)

    self.button:animate_click(blackout, scale, duration, easing)

    GameGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button:on_click(action)
    end)
end

return PauseButtonView
