local App = require('src.app')
local GameDataService = require('src.systems.game.game_data_service')
local BlocksController = require('src.systems.game.controllers.blocks_controller')

local Services = App.services

local ScreenService = Services.screen

local GameSceneSystem = {}

function GameSceneSystem:init()
    ScreenService:add_listener(msg.url())

    local current_level = 1

    GameDataService:init(current_level)

    self.blocks = BlocksController:build()
end

function GameSceneSystem:on_message(message_id)
    ScreenService:on_message(message_id, function ()
        BlocksController:rebuild(self.blocks)
    end)
end

return GameSceneSystem
