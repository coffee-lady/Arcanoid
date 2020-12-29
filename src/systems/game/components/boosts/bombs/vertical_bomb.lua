local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.vertical_bomb
local MSG = App.constants.messages

local VerticalBombBoost = {}

local function boost(self)
    for i = 1, #self.blocks do
        local block = self.blocks[i]

        if block then
            local block_pos = go.get_position(block.id)

            if block_pos.x == self.pos.x then
                SceneMsgService:send(block.id, MSG.game.destroy_block)
                table.remove(self.blocks, i)
            end
        end
    end
end

function VerticalBombBoost:init(message, blocks)
    self.blocks = blocks
    self.pos = message.pos

    Boost:new(message.pos, BoostConfig, function()
        boost(self)
    end)
end

return VerticalBombBoost
