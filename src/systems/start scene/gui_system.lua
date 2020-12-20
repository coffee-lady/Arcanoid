local Controllers = require('src.systems.start scene.controllers.controllers')
local GameServices = require('src.systems.start scene.services.services')

local GameGuiMsgService = GameServices.gui_msg

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
end

function GameSceneGUISystem:on_message(message_id, message)
    GameGuiMsgService:send(message.receiver, message_id, message.data)
end

return GameSceneGUISystem
