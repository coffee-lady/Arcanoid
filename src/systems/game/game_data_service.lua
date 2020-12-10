local App = require('src.app')

local Services = App.services

local DataService = Services.data

local GameDataService = {}

function GameDataService:init(level)
    self.current_level = level

    if not DataService:get('levels', 'current') then
        DataService:set('levels', 'current', level)
    end

    self:set_level(self.current_level)
end

function GameDataService:set_level(level)
    self.current_level = level

    local level_data = sys.load_resource('/src/resources/levels/level_' .. self.current_level .. '.json')
    self.level_data = json.decode(level_data)

    local blocks_data = sys.load_resource('/src/resources/levels/blocks.json')
    self.blocks_types = json.decode(blocks_data)
end

function GameDataService:get_current_level_data()
    return self.level_data
end

function GameDataService:get_blocks_types()
    return self.blocks_types
end

function GameDataService:get_block_property(block, prop)
    return self.blocks_types[block][prop] and self.blocks_types[block][prop] or self.blocks_types.default[prop]
end


return GameDataService
