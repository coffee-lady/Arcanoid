local Services = require('src.services.services')

local ScreenService = Services.screen

local function get_block_length(config, level_data)
    local sizes = ScreenService:get_sizes()
    local grid_size = level_data.sizes

    local indents_length = 2 * config.sides_padding + (grid_size.x - 1) * config.indent_between

    return (sizes.x - indents_length) / grid_size.x
end

return function(block, config, level_data)
    block.length = get_block_length(config, level_data)
end
