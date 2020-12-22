local App = require('src.app')
local PopupServices = require('src.systems.game losing popup.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = PopupServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls

local PopupGuiURLs = URL.gui_nodes.game_losing_popup
local POPUP_URL = URL.popups.game_losing_popup

local SUBSCRIPTION = 'LocalizationController'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    self.msg_subs = SceneGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(POPUP_URL)

    LocalizationLib:update_gui({{
        node = gui.get_node(PopupGuiURLs.text.title),
        text = TEXT_DATA.title
    }, {
        node = gui.get_node(PopupGuiURLs.text.button_back_text),
        text = TEXT_DATA.button_back_text
    }, {
        node = gui.get_node(PopupGuiURLs.text.button_restart_text),
        text = TEXT_DATA.button_restart_text
    }})
end

function LocalizationController:final()
    self.msg_subs:unsubscribe()
end

return LocalizationController
