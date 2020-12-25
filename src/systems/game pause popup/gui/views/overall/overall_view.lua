local App = require('src.app')
local class = App.libs.middleclass
local PopupServices = require('src.systems.game pause popup.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local PopupGuiMsgService = PopupServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local PopupGuiURL = URL.gui_nodes.game_pause_popup

local SUBSCRIPTION = 'PopupView'

local PopupView = class('PopupView')

local function create_buttons(self)
    local btn_restart_node = gui.get_node(PopupGuiURL.button_restart)
    local btn_continue_node = gui.get_node(PopupGuiURL.button_continue)
    local btn_back_node = gui.get_node(PopupGuiURL.button_back)

    self.button_continue = Button:new(btn_continue_node, GUIButtonConfig, function()
        self.continue_observer:next()
    end)

    self.button_restart = Button:new(btn_restart_node, GUIButtonConfig, function()
        self.restart_observer:next()
    end)

    self.button_back = Button:new(btn_back_node, GUIButtonConfig, function()
        self.back_observer:next()
    end)

    PopupGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
        self.button_continue:on_click(action)
        self.button_restart:on_click(action)
        self.button_back:on_click(action)
    end)
end

function PopupView:initialize()
    self.continue_observer = Observable:new()
    self.restart_observer = Observable:new()
    self.back_observer = Observable:new()

    create_buttons(self)
end

function PopupView:final()
    self.continue_observer:complete()
    self.restart_observer:complete()
    self.back_observer:complete()
end

return PopupView
