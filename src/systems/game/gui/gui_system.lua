local App = require('src.app')
local Controllers = require('src.systems.game.gui.controllers.controllers')
local GameServices = require('src.systems.game.services.services')

local GameGuiMsgService = GameServices.gui_msg

local URL = App.constants.urls
local LivesController = Controllers.lives
local PauseButtonController = Controllers.pause_button

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    LivesController:init()
    PauseButtonController:init()
end

function GameSceneGUISystem:on_message(message_id, message)
    GameGuiMsgService:send(message.receiver, message_id, message.data)
end

function GameSceneGUISystem:on_input(action_id, action)
    GameGuiMsgService:send(nil, action_id, action)
end

return GameSceneGUISystem
