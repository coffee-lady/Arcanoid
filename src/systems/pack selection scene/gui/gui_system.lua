local Controllers = require('src.systems.pack selection scene.gui.controllers.controllers')
local GameServices = require('src.systems.pack selection scene.services.services')

local SceneGuiMsgService = GameServices.gui_msg

local SceneGUISystem = {}

function SceneGUISystem:init()
end

function SceneGUISystem:on_message(message_id, message)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)
end

return SceneGUISystem
