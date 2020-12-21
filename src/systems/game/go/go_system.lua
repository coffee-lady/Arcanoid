local GameServices = require('src.systems.game.services.services')
local Controllers = require('src.systems.game.go.controllers.controllers')

local SceneMsgService = GameServices.msg

local BlocksController = Controllers.blocks
local BallController = Controllers.ball
local WallsController = Controllers.walls
local PlatformController = Controllers.platform
local LevelController = Controllers.level

local GameSceneSystem = {}

function GameSceneSystem:init()
    LevelController:init()

    BlocksController:build(LevelController:get_data())

    BallController:init()
    WallsController:init()
    PlatformController:init()
end

function GameSceneSystem:on_input(action_id, action)
    PlatformController:on_input(action_id, action)
end

function GameSceneSystem:on_message(message_id, message)
    SceneMsgService:send(message.receiver, message_id, message.data)
end

function GameSceneSystem:final()
    SceneMsgService:reset()
end

return GameSceneSystem
