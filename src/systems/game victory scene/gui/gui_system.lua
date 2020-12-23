local App = require('src.app')
local Controllers = require('src.systems.game victory scene.gui.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization

local MSG = App.constants.messages

local OverallController = Controllers.overall
local LocalizationController = Controllers.localization
local TransitionsController = Controllers.transitions

local SceneGUISystem = {}

function SceneGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    TransitionsController:init()
end

function SceneGUISystem:on_message(message_id, message, sender)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)

    TransitionsController:on_message(message_id, message, sender)
end

function SceneGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function SceneGUISystem:final()
    OverallController:final()
    LocalizationController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()

    TransitionsController:final()
end

return SceneGUISystem
