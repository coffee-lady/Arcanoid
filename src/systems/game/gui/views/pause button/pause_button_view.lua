local App = require('src.app')
local class = App.libs.middleclass
local GameServices = require('src.systems.game.services.services')

local Button = App.libs.gui.button

local GameGuiMsgService = GameServices.gui_msg

local Config = App.config
local Actions = App.constants.actions
local GameURL = App.constants.urls.gui_nodes.game_scene

local VConfig = Config
local GUIVConfig = Config

local SUBSCRIPTION = 'PauseButtonView'

local PauseButtonView = class('PauseButtonView')

function PauseButtonView:initialize()
    self.button = Button:new(gui.get_node(GameURL.pause_button))

    -- test!
    self.button:animate_click(0, {
        x = 0.3,
        y = 0.3
    }, 1, gui.EASING_LINEAR)

    GameGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button:on_click(action)
    end)
end

return PauseButtonView
