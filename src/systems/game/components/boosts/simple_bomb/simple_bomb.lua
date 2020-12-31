local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local Coords = App.libs.coords
local hypotenuse = Coords.hypotenuse
local vlength = Coords.vlength

local BoostConfig = App.config.game.boosts.bomb
local MSG = App.constants.messages
local BlockConfig = App.config.game.go.blocks

local SimpleBombBoost = class('SimpleBombBoost', Boost)

SimpleBombBoost.weight = BoostConfig.weight

function SimpleBombBoost:initialize(id, message)
    Boost.initialize(self, id, BoostConfig)

    self.block_length = message.length
    self.block_height = message.height
    self.blocks = BlocksData:get()
    self.pos = message.pos
end

function SimpleBombBoost:boost()
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

return SimpleBombBoost
