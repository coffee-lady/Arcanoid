local App = require('src.app')
local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')

local BlockBuilder = Models.block_builder
local BlockView = Views.block

local Config = App.config

local BlocksGridConfig = Config.game.blocks

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
