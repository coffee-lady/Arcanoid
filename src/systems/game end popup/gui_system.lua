local Controllers = require('src.systems.game end popup.controllers.controllers')
local GameServices = require('src.systems.game end popup.services.services')

local SceneGuiMsgService = GameServices.gui_msg

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
end

function GameSceneGUISystem:on_message(message_id, message)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)
end

return GameSceneGUISystem
