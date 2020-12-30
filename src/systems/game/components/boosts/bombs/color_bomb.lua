local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local Coords = App.libs.coords
local vlength = Coords.vlength

local BoostConfig = App.config.game.boosts.color_bomb
local MSG = App.constants.messages
local BlockConfig = App.config.game.go.blocks

local ColorBombBoost = class('ColorBombBoost', Boost)

ColorBombBoost.weight = BoostConfig.weight

function ColorBombBoost:initialize(message, blocks)
    self.block_length = message.length
    self.block_height = message.height
    self.blocks = blocks
    self.pos = message.pos
    self.config = BoostConfig
end

function ColorBombBoost:boost()
    local height = self.block_height
    local length = self.block_length
    local indent = BlockConfig.indent_between

    local vertical_dist = height + indent
    local horizontal_dist = length + indent

    local types_count = {}
    local typed_blocks = {}
    local max

    for i = 1, #self.blocks do
        local block = self.blocks[i]
        if block then
            local block_pos = go.get_position(block.id)
            local dist = vlength(block_pos, self.pos)

            if dist == vertical_dist or dist == horizontal_dist then
                local type_count = types_count[block.type]

                if type_count then
                    type_count = type_count + 1
                else
                    type_count = 1
                end

                types_count[block.type] = type_count

                local typed_ref = typed_blocks[block.type]
                if not typed_ref then
                    typed_blocks[block.type] = {}
                    typed_ref = typed_blocks[block.type]
                end
                typed_ref[#typed_ref + 1] = block

                if not max then
                    max = block.type
                end

                if type_count > types_count[max] then
                    max = block.type
                end
            end
        end
    end

    if not typed_blocks[max] then
        return
    end

    for i = 1, #typed_blocks[max] do
        local block = typed_blocks[max][i]

        for j = 1, #self.blocks do
            if self.blocks[j] and self.blocks[j].id == block.id then
                table.remove(self.blocks, j)
            end
        end

        SceneMsgService:send(block.id, MSG.game.destroy_block)
    end
end

return ColorBombBoost
