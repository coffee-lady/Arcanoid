local Controllers = require('src.systems.game.controllers.controllers')

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

return GameSceneSystem
