local App = require('src.app')
local Components = require('src.systems.game.components.components')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks

local BlocksDataService = SceneServices.blocks_data
local SceneUrls = App.constants.urls.scenes.game_scene

local LevelService = Services.level

local Block = Components.block

local Factory = {}

function Factory:init()
    local level_data = LevelService:get_data()
    local TYPES = BlocksDataService:get_data()

    for i = 1, #level_data.grid do
        local raw_data = level_data.grid[i]

        for key, value in pairs(TYPES[raw_data.type]) do
            raw_data[key] = value
        end

        raw_data.grid_pos = raw_data.pos

        local id = factory.create(SceneUrls.block_factory)

        local block = Block:new(id, raw_data)

        BlocksData:add(block)
    end
end

return Factory
