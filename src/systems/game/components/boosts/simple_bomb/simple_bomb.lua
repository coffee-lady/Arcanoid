local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local LevelService = Services.level
local ScreenService = Services.screen

local Coords = App.libs.coords
local hypotenuse = Coords.hypotenuse
local vlength = Coords.vlength

local BoostConfig

local MSG = App.constants.messages
local BlockConfig = App.config.game.go.blocks

local SimpleBombBoost = class('SimpleBombBoost', Boost)

function SimpleBombBoost:initialize(id, message, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)

    self.block_length = message.length
    self.block_height = message.height
    self.blocks = BlocksData:get()
    self.pos = message.pos
end

function SimpleBombBoost:boost()
    local height = self.block_height
    local length = self.block_length

    local level_data = LevelService:get_data()
    local sizes = ScreenService:get_sizes()
    local grid_size = level_data.sizes
    local indent = BlockConfig.indent_between * sizes.x / grid_size.x

    local vertical_dist = math.ceil(height + indent)
    local horizontal_dist = math.ceil(length + indent)
    local diagonal_dist = math.ceil(hypotenuse(height / 2, length / 2) * 2 + hypotenuse(indent, indent))

    for i = 1, #self.blocks do
        local block = self.blocks[i]

        if block then
            local block_pos = go.get_position(block.id)
            local dist = math.ceil(vlength(block_pos, self.pos))

            if dist == vertical_dist or dist == horizontal_dist or dist == diagonal_dist then
                SceneMsgService:send(block.id, MSG.game.damage_block, {
                    damage = BoostConfig.damage
                })
            end
        end
    end
end

return SimpleBombBoost
