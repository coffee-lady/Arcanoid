local App = require('src.app')
local PopupServices = require('src.systems.game pause popup.services.services')
local Services = require('src.services.services')

local GameGuiMsgService = PopupServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls
local PopupGuiURL = URL.gui_nodes.game_pause_popup

local SUBSCRIPTION = 'LocalizationController'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    self.msg_subs = GameGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(URL.popups.game_pause_popup)

    LocalizationLib:update_gui({{
        node = gui.get_node(PopupGuiURL.text.title),
        text = TEXT_DATA.title
    }, {
        node = gui.get_node(PopupGuiURL.text.button_back_text),
        text = TEXT_DATA.button_back_text
    }, {
        node = gui.get_node(PopupGuiURL.text.button_continue_text),
        text = TEXT_DATA.button_continue_text
    }, {
        node = gui.get_node(PopupGuiURL.text.button_restart_text),
        text = TEXT_DATA.button_restart_text
    }})
end

function LocalizationController:final()
    self.msg_subs:unsubscribe()
end

return LocalizationController
