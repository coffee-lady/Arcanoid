local Controllers = require('src.systems.game.controllers.controllers')
local GameServices = require('src.systems.game.services.services')

local GameGuiMsgService = GameServices.gui_msg

local LivesController = Controllers.lives

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    LivesController:init()
end

function GameSceneGUISystem:on_message(message_id, message)
    GameGuiMsgService:send(message.receiver, message_id, message.data)
end

return GameSceneGUISystem
