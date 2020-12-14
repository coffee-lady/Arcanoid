local Resources = {
    level_data = {
        path = '/src/resources/levels/level_',
        type = 'json'
    },
    blocks_data = {
        path = '/src/resources/levels/blocks',
        type = 'json'
    },
}

function Resources:get_level_filepath(level)
    return self.level_data.path .. level .. '.' .. self.level_data.type
end

function Resources:get_blocks_data_filepath()
    return self.blocks_data.path .. '.' .. self.blocks_data.type
end

return Resources
