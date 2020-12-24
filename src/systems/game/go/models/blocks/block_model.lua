local App = require('src.app')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local ResourcesLib = App.libs.resources_storage
local GameRes = App.config.game.resources

local blocks_types = ResourcesLib:get(GameRes:get_blocks_data_filepath(), GameRes.blocks_data.type)

local function get_prop(block, prop)
    local value = blocks_types[block][prop]

    if value ~= nil then
        return value
    else
        return blocks_types.default[prop]
    end
end

local Block = class('Block')

function Block:initialize(block_data, grid_y)
    self.type = block_data.type
    self.grid_pos = {
        x = block_data.x,
        y = grid_y
    }
    self.default_width = get_prop(self.type, 'width')
    self.default_height = get_prop(self.type, 'height')
    self.destroyable = get_prop(self.type, 'destroyable')
    self.lives = get_prop(self.type, 'lives')
    self.sprite = hash(get_prop(self.type, 'sprite'))

    self.update_observer = Observable:new()
    self.lives_observer = Observable:new()
end

function Block:set_id(id)
    self.id = id
end

function Block:decrease_lives()
    if not self.destroyable then
        return
    end

    self.lives = self.lives - 1
    self.lives_observer:next(self.lives)

    if self.lives == 0 then
        self:delete()
    end
end

function Block:delete()
    self.update_observer:complete()
    self.lives_observer:complete()
end

return Block
