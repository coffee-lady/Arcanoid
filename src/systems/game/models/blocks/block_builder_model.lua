local BlockModel = require('src.systems.game.models.blocks.block_model')
local Services = require('src.services.services')

local ScreenService = Services.screen

local BlocksBuilder = {}

function BlocksBuilder:build(level_data, config)
    self.config = config
    self.level_data = level_data

    local blocks = {}

    for _, row in pairs(self.level_data.grid) do
        for i = 1, #row do
            blocks[#blocks + 1] = BlockModel:new(row[i].block)
        end
    end

    self:_update_blocks(blocks)

    return blocks
end

function BlocksBuilder:rebuild(blocks, config)
    if not config then config = self.config end

    self:_update_blocks(blocks)
end

function BlocksBuilder:_update_blocks(blocks)
    local block_length = self:get_block_length()
    local start = self:get_start_pos(block_length)

    local k = 1
    for _, row in pairs(self.level_data.grid) do
        for i = 1, #row do
            local scale = self:calculate_scale(block_length, blocks[k])
            local pos = self:calculate_pos(start, block_length, scale, blocks[k], row[i])

            blocks[k]:update(pos, scale)
            k = k + 1
        end
    end
end

function BlocksBuilder:get_block_length()
    local sizes = ScreenService:get_sizes()
    local grid_size = self.level_data.sizes

    local indents_length = 2 * self.config.sides_padding + (grid_size.x - 1) * self.config.indent_between

    return (sizes.x - indents_length) / grid_size.x
end

function BlocksBuilder:get_start_pos(block_length)
    local start_coords, end_coords = ScreenService:get_coords()

    local start = {}

    start.x = start_coords.x + self.config.sides_padding + block_length / 2
    start.y = end_coords.y - self.config.top_padding

    return start
end

function BlocksBuilder:calculate_scale(block_length, block)
    local scale = block_length / block.default_width

    return vmath.vector3(scale, scale, scale)
end

function BlocksBuilder:calculate_pos(start, block_length, scale, block, grid_block)
    local pos = vmath.vector3(0, 0, 0)

    pos.x = start.x + grid_block.pos.x * block_length + grid_block.pos.x * self.config.indent_between

    local indent_top = block.default_height * scale.y / 2 + grid_block.pos.y * block.default_height * scale.y
    pos.y = start.y - indent_top - grid_block.pos.y * self.config.indent_between

    return pos
end

return BlocksBuilder
