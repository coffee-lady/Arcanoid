local App = require('src.app')
local BlockBuilder = require('src.systems.game.models.blocks.block_builder_model')
local BlockView = require('src.systems.game.views.block_view')

local Config = App.config

local BlocksGridConfig = Config.game.blocks_grid

local BlocksController = {}

function BlocksController:build(level_data)
    local blocks = BlockBuilder:build(level_data, BlocksGridConfig)

    for i = 1, #blocks do
        BlockView:new(blocks[i])
    end

    return blocks
end

function BlocksController:rebuild(blocks)
    BlockBuilder:rebuild(blocks)
end

return BlocksController
