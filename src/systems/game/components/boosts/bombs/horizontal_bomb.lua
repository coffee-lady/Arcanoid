local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.horizontal_bomb
local MSG = App.constants.messages

local HorizontalBombBoost = class('HorizontalBombBoost', Boost)

HorizontalBombBoost.weight = BoostConfig.weight

function HorizontalBombBoost:initialize(message, blocks)
    self.blocks = blocks
    self.pos = message.pos
    self.config = BoostConfig
end

function HorizontalBombBoost:boost()
    for i = 1, #self.blocks do
        local block = self.blocks[i]
        if block then
            local block_pos = go.get_position(block.id)

            if block_pos.y == self.pos.y then
                table.remove(self.blocks, i)
                SceneMsgService:send(block.id, MSG.game.destroy_block)
            end
        end
    end
end

return HorizontalBombBoost
