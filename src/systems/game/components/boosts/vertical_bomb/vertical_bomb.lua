local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local VerticalBombBoost = class('VerticalBombBoost', Boost)

function VerticalBombBoost:initialize(id, message, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
    self.blocks = BlocksData:get()
    self.pos = message.pos

    self.config = BoostConfig
end

function VerticalBombBoost:boost()
    for i = 1, #self.blocks do
        local block = self.blocks[i]

        if block then
            local block_pos = go.get_position(block.id)

            if block_pos.x == self.pos.x then
                SceneMsgService:send(block.id, MSG.game.destroy_block)
            end
        end
    end
end

return VerticalBombBoost
