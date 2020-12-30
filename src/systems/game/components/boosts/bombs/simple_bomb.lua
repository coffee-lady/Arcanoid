local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local Coords = App.libs.coords
local hypotenuse = Coords.hypotenuse
local vlength = Coords.vlength

local BoostConfig = App.config.game.boosts.bomb
local MSG = App.constants.messages
local BlockConfig = App.config.game.go.blocks

local SimpleBombBoost = {
    weight = BoostConfig.weight
}

local function boost(self)
    local height = self.block_height
    local length = self.block_length
    local indent = BlockConfig.indent_between

    local vertical_dist = height + indent
    local horizontal_dist = length + indent
    local diagonal_dist = hypotenuse(height / 2, length / 2) * 2 + hypotenuse(indent, indent)

    for i = 1, #self.blocks do
        local block = self.blocks[i]

        if block then
            local block_pos = go.get_position(block.id)
            local dist = vlength(block_pos, self.pos)

            if dist == vertical_dist or dist == horizontal_dist or dist == diagonal_dist then
                SceneMsgService:send(block.id, MSG.game.damage_block, {
                    damage = BoostConfig.damage
                })
            end
        end
    end
end

function SimpleBombBoost:init(message, blocks)
    self.block_length = message.length
    self.block_height = message.height
    self.blocks = blocks
    self.pos = message.pos

    Boost:new(message.pos, BoostConfig, function()
        boost(self)
    end)
end

return SimpleBombBoost
