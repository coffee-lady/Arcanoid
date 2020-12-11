local GameDataService = require('src.systems.game.game_data_service')
local BlocksController = require('src.systems.game.controllers.blocks_controller')

local Services = require('src.services.services')

local ScreenService = Services.screen

local GameSceneSystem = {}

function GameSceneSystem:init()
    local current_level = 1

    GameDataService:init(current_level)

    self.blocks = BlocksController:build()

    ScreenService.observer:subscribe(function ()
        BlocksController:rebuild(self.blocks)
    end)

end

return GameSceneSystem
