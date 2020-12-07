local GameDataService = require('src.systems.game.game_data_service')

local Block = {}

function Block:new(pos, scale, block_type)
    local color = GameDataService:get_block_property(block_type, 'color')
    local block = {
        pos = vmath.vector3(pos.x, pos.y, 0),
        scale = vmath.vector3(scale, 1, 1),
        block_type = block_type,
        lives = GameDataService:get_block_property(block_type, 'lives'),
        color = vmath.vector4(color[1], color[2], color[3], color[4]),
    }

    self.__index = self
    return setmetatable(block, self)
end

return Block
