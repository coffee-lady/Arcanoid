local App = require('src.app')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local ResourcesLib = App.libs.resources_storage
local GameRes = App.config.game.resources

local blocks_types = ResourcesLib:get(GameRes:get_blocks_data_filepath(),
        GameRes.blocks_data.type)

local function get_prop(block, prop)
    local value = blocks_types[block][prop]

    return value and value or blocks_types.default[prop]
end

local Block = class('Block')

function Block:initialize(block_type)
    self.pos = {}
    self.default_width = get_prop(block_type, 'width')
    self.default_height = get_prop(block_type, 'height')
    self.lives = get_prop(block_type, 'lives')
    self.color = get_prop(block_type, 'color')
    self.type = block_type

    self.observer = Observable:new()
end

function Block:update(pos, scale)
    self.pos = pos
    self.scale = scale

    self.observer:next()
end

function Block:delete()
    self.observer:complete()
end

return Block
