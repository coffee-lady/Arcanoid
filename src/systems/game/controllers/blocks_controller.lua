local App = require('src.app')
local BlockBuilder = require('src.systems.game.models.block_builder_model')
local BlockView = require('src.systems.game.views.block_view')

local Config = App.config
local Messages = App.constants.messages

local BlocksGridConfig = Config.game.blocks_grid

local BlocksController = {}

function BlocksController:build()
    local blocks = BlockBuilder:build(BlocksGridConfig.block_height,
            BlocksGridConfig.top_padding,
            BlocksGridConfig.sides_padding,
            BlocksGridConfig.indent_between)

    for i = 1, #blocks do
        blocks[i].id = BlockView:create(blocks[i])
    end

    return blocks
end

function BlocksController:rebuild(blocks)
    BlockBuilder:rebuild(blocks, BlocksGridConfig.block_height,
        BlocksGridConfig.top_padding,
        BlocksGridConfig.sides_padding,
        BlocksGridConfig.indent_between)

    for i = 1, #blocks do
        BlockView:rebuild(blocks[i])
    end
end

return BlocksController
