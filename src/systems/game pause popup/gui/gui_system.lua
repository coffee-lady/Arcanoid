local App = require('src.app')
local Controllers = require('src.systems.game pause popup.gui.controllers.controllers')
local PopupServices = require('src.systems.game pause popup.services.services')
local Services = require('src.services.services')

local PopupGuiMsgService = PopupServices.gui_msg
local LocalizationService = Services.localization
local ScenesTransitions = App.libs.scenes_transitions

local URL = App.constants.urls
local MSG = App.constants.messages
local TransitionSettings = App.config.transitions.game_pause_popup
local PopupGuiURLs = URL.gui_nodes.game_pause_popup

local OverallController = Controllers.overall
local LocalizationController = Controllers.localization

local PausePopupGUISystem = {}

function PausePopupGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        PopupGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    self.transition = ScenesTransitions:new(PopupGuiURLs.root)
    self.transition:auto_set(TransitionSettings)
end

function PausePopupGUISystem:on_message(message_id, message, sender)
    PopupGuiMsgService:send(message.receiver, message_id, message.data)

    self.transition:on_message(message_id, message, sender)
end

function PausePopupGUISystem:on_input(action_id, action)
    PopupGuiMsgService:send(nil, action_id, action)
end

function PausePopupGUISystem:final()
    OverallController:final()
    LocalizationController:final()

    self.local_subs:unsubscribe()

    PopupGuiMsgService:reset()

    self.transition:final()
end

return PausePopupGUISystem
