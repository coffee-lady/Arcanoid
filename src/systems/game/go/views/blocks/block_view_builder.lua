local BlockView = require('src.systems.game.go.views.blocks.block_view')
local Utils = require('src.systems.game.go.views.blocks.utils.utils')

local set_length = Utils.set_length
local set_scale = Utils.set_scale
local set_position = Utils.set_position

local BlockViewsBuilder = {}

local function _update_block(self, block_view)
    set_length(block_view, self.config, self.level_data)
    set_scale(block_view)
    set_position(block_view, self.config)
end

function BlockViewsBuilder:build(blocks, blocks_views, level_data, config)
    self.config = config
    self.level_data = level_data

    for i = 1, #blocks do
        local block_view = BlockView:new(blocks[i])
        blocks_views[#blocks_views + 1] = block_view

        _update_block(self, block_view)

        block_view:create_go()
    end
end

function BlockViewsBuilder:rebuild(blocks_views, config)
    if not config then
        config = self.config
    end

    for i = 1, #blocks_views do
        local block_view = blocks_views[i]
        if block_view then
            _update_block(self, block_view)

            block_view:rebuild()
        end
    end
end

return BlockViewsBuilder
