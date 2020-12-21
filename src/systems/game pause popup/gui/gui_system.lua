local App = require('src.app')
local Controllers = require('src.systems.game pause popup.gui.controllers.controllers')
local PopupServices = require('src.systems.game pause popup.services.services')
local Services = require('src.services.services')

local PopupGuiMsgService = PopupServices.gui_msg
local LocalizationService = Services.localization

local MSG = App.constants.messages

local OverallController = Controllers.overall
local LocalizationController = Controllers.localization

local PausePopupGUISystem = {}

function PausePopupGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        PopupGuiMsgService:send(nil, MSG.common.localization_change)
    end)
end

function PausePopupGUISystem:on_message(message_id, message)
    PopupGuiMsgService:send(message.receiver, message_id, message.data)
end

function PausePopupGUISystem:on_input(action_id, action)
    PopupGuiMsgService:send(nil, action_id, action)
end

function PausePopupGUISystem:final()
    OverallController:final()
    LocalizationController:final()

    self.local_subs:unsubscribe()

    PopupGuiMsgService:reset()
end

return PausePopupGUISystem
