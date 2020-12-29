local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.horizontal_bomb
local MSG = App.constants.messages

local HorizontalBombBoost = {}

local function boost(self)
    for i = 1, #self.blocks do
        local block = self.blocks[i]
        if block then
            local block_pos = go.get_position(block.id)

            if block_pos.y == self.pos.y then
                SceneMsgService:send(block.id, MSG.game.destroy_block)
                table.remove(self.blocks, i)
            end
        end
    end
end

function HorizontalBombBoost:init(message, blocks)
    self.blocks = blocks
    self.pos = message.pos

    Boost:new(message.pos, BoostConfig, function()
        boost(self)
    end)
end

return HorizontalBombBoost
