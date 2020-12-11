local App = require('src.app')
local BlockBuilder = require('src.systems.game.models.block_builder_model')
local BlockView = require('src.systems.game.views.block_view')

local Config = App.config
local Messages = App.constants.messages

local BlocksGridConfig = Config.game.blocks_grid

local BlocksController = {}

function BlocksController:build()
    local blocks = BlockBuilder:build(BlocksGridConfig)

    for i = 1, #blocks do
        BlockView:create(blocks[i])
    end

    return blocks
end

function BlocksController:rebuild(blocks)
    BlockBuilder:rebuild(blocks, BlocksGridConfig)

    for i = 1, #blocks do
        BlockView:rebuild(blocks[i])
    end
end

return BlocksController
