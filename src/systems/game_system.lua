local Models = require('src.systems.game.models.models')
local Controllers = require('src.systems.game.controllers.controllers')

local BlocksController = Controllers.blocks
local BallController = Controllers.ball
local WallsController = Controllers.walls
local PlatformController = Controllers.platform

local Level = Models.level

local Services = require('src.services.services')

local ScreenService = Services.screen

local GameSceneSystem = {}

function GameSceneSystem:init()
    self.level = Level:new(1)

    self.blocks = BlocksController:build(self.level:get_data())

    ScreenService.observer:subscribe(function()
        BlocksController:rebuild(self.blocks)
    end)

    BallController:init()
    WallsController:init()
    PlatformController:init()
end

return GameSceneSystem
