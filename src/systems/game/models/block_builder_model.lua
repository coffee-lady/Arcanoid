local App = require('src.app')
local BlockModel = require('src.systems.game.models.block_model')
local GameDataService = require('src.systems.game.game_data_service')

local Services = App.services

local ScreenService = Services.screen

local BlocksBuilder = {}

function BlocksBuilder:build(config)
    local blocks = {}
    local start_coords, end_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()
    local level_data = GameDataService:get_current_level_data()

    local pos = vmath.vector3(0, 0, 0)

    local start_y = end_coords.y - config.top_padding - config.block_height / 2
    local grid_size = level_data.sizes

    for _, row in pairs(level_data.grid) do
        local block_length = (sizes.x - 2 * config.sides_padding - (grid_size.x - 1) * config.indent_between) / grid_size.x
        local start_x = start_coords.x + config.sides_padding + block_length / 2
        pos.y = start_y - row[1].pos.y * config.block_height - (row[1].pos.y) * config.indent_between

        for i = 1, #row do
            local scale = block_length / GameDataService:get_block_property(row[i].block, 'width')

            pos.x = start_x + row[i].pos.x * block_length + row[i].pos.x * config.indent_between

            blocks[#blocks + 1] = BlockModel:new(pos, scale, row[i].block)
        end
    end

    return blocks
end

function BlocksBuilder:rebuild(blocks, config)
    local start_coords, end_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()
    local level_data = GameDataService:get_current_level_data()

    local pos = vmath.vector3(0, 0, 0)

    local start_y = end_coords.y - config.top_padding
    local grid_size = level_data.sizes

    local k = 1
    for _, row in pairs(level_data.grid) do
        local block_length = (sizes.x - 2 * config.sides_padding - (grid_size.x - 1) * config.indent_between) / grid_size.x
        local start_x = start_coords.x + config.sides_padding + block_length / 2

        for i = 1, #row do
            local scale = block_length / GameDataService:get_block_property(row[i].block, 'width')
            pos.y = start_y - config.block_height * scale / 2 - row[1].pos.y * config.block_height * scale - (row[1].pos.y) * config.indent_between

            pos.x = start_x + row[i].pos.x * block_length + row[i].pos.x * config.indent_between

            blocks[k].pos.x, blocks[k].pos.y = pos.x, pos.y
            blocks[k].scale = vmath.vector3(scale, scale, scale)
            k = k + 1
        end
    end
end

return BlocksBuilder
