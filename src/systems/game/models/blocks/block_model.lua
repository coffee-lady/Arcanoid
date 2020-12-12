local App = require('src.app')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local ResourcesLib = App.libs.resources_storage
local GameRes = App.config.game.resources

local blocks_types = ResourcesLib:get(GameRes:get_blocks_data_filepath(), GameRes.blocks_data.type)

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
    self.sprite = hash(get_prop(block_type, 'sprite'))
    print(self.sprite)

    self.type = block_type

    self.update_observer = Observable:new()
end

function Block:update(pos, scale)
    self.pos = pos
    self.scale = scale

    self.update_observer:next()
end

function Block:delete()
    self.update_observer:complete()
end

return Block
