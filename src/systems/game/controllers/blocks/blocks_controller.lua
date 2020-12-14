local App = require('src.app')
local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')
local Services = require('src.services.services')

local BlockBuilder = Models.block_builder
local BlockView = Views.block

local ScreenService = Services.screen

local Config = App.config

local BlocksConfig = Config.game.go.blocks

local BlocksController = {}

function BlocksController:build(level_data)
    self.blocks = BlockBuilder:build(level_data, BlocksConfig)

    for i = 1, #self.blocks do
        local block = self.blocks[i]
        local view = BlockView:new(block)

        block:subscribe_to_collision()

        block.lives_observer:subscribe(nil, function()
            for j = 1, #self.blocks do
                if self.blocks[j].id == block.id then
                    table.remove(self.blocks, j)
                    break
                end
            end
            view:delete()
        end)
    end

    ScreenService.update_observer:subscribe(function()
        self:rebuild()
    end)
end

function BlocksController:rebuild()
    BlockBuilder:rebuild(self.blocks)
end

return BlocksController
