local App = require('src.app')
local Controllers = require('src.systems.game victory scene.gui.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization

local MSG = App.constants.messages

local OverallController = Controllers.overall
local LocalizationController = Controllers.localization

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)
end

function GameSceneGUISystem:on_message(message_id, message)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)
end

function GameSceneGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function GameSceneGUISystem:final()
    OverallController:final()
    LocalizationController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()
end

return GameSceneGUISystem
