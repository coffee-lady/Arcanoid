local App = require('src.app')
local GameServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local GameMsgService = GameServices.msg

local ResourcesLib = App.libs.resources_storage
local GameRes = App.config.game.resources
local MSG = App.constants.messages.common

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

function Block:initialize(block_type, grid_pos)
    self.pos = {}

    self.type = block_type
    self.grid_pos = grid_pos
    self.default_width = get_prop(self.type, 'width')
    self.default_height = get_prop(self.type, 'height')
    self.destroyable = get_prop(self.type, 'destroyable')
    self.lives = get_prop(self.type, 'lives')
    self.sprite = hash(get_prop(self.type, 'sprite'))

    self.update_observer = Observable:new()
    self.lives_observer = Observable:new()
end

function Block:update(pos, scale)
    self.pos = pos
    self.scale = scale

    self.update_observer:next()
end

function Block:subscribe_to_collision()
    if not self.destroyable then
        return
    end

    GameMsgService:on(self.id, MSG.collision_response, function()
        self:on_collision()
    end)
end

function Block:on_collision()
    self.lives = self.lives - 1
    self.lives_observer:next()

    if self.lives == 0 then
        self:delete()
    end
end

function Block:delete()
    self.update_observer:complete()
    self.lives_observer:complete()
end

return Block
