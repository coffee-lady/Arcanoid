local App = require('src.app')
local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')
local Services = require('src.services.services')
local GameServices = require('src.systems.game.services.services')

local BlockBuilder = Models.block_builder
local BlockView = Views.block

local ScreenService = Services.screen
local GameMsgService = GameServices.msg

local Config = App.config
local MSG = App.constants.messages.game

local BlocksGridConfig = Config.game.blocks

local BlocksController = {}

function BlocksController:build(level_data)
    self.blocks = BlockBuilder:build(level_data, BlocksGridConfig)

    for i = 1, #self.blocks do
        local view = BlockView:new(self.blocks[i])

        self.blocks[i]:subscribe_to_collision()

        self.blocks[i].lives_observer:subscribe(nil, function()
            table.remove(self.blocks, i)
            view:delete()
        end)
    end

    ScreenService.observer:subscribe(function()
        self:rebuild()
    end)
end

function BlocksController:rebuild()
    BlockBuilder:rebuild(self.blocks)
end

return BlocksController
