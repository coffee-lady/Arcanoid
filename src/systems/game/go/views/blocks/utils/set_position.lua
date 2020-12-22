local Services = require('src.services.services')

local ScreenService = Services.screen

local function get_start_pos(block, config)
    local start_coords, end_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()

    local start = {}

    start.x = start_coords.x + config.sides_padding + block.length / 2
    start.y = end_coords.y - config.top_padding * sizes.y

    return start
end

local function set_pos(block, config)
    local grid_pos = block.data.grid_pos
    local default_height = block.data.default_height
    local start_pos = get_start_pos(block, config)

    if not block.pos then
        block.pos = vmath.vector3()
    end

    block.pos.x = start_pos.x + grid_pos.x * block.length + grid_pos.x * config.indent_between

    local indent_top = default_height * block.scale.y / 2 + grid_pos.y * default_height * block.scale.y
    block.pos.y = start_pos.y - indent_top - grid_pos.y * config.indent_between
end

return function(block, config)
    set_pos(block, config)
end
