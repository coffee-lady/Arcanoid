local BlocksController = require('src.systems.game.controllers.blocks_controller')
local Level = require('src.systems.game.models.level.level_model')

local Services = require('src.services.services')

local ScreenService = Services.screen

local GameSceneSystem = {}

function GameSceneSystem:init()
    self.level = Level:new(1)

    self.blocks = BlocksController:build(self.level:get_data())

    ScreenService.observer:subscribe(function ()
        BlocksController:rebuild(self.blocks)
    end)
end

return GameSceneSystem
