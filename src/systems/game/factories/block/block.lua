local App = require('src.app')
local Components = require('src.systems.game.components.components')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local BlocksDataService = SceneServices.blocks_data
local SceneUrls = App.constants.urls.scenes.game_scene

local LevelService = Services.level

local Block = Components.block

local Factory = {}

function Factory:init()
    local level_data = LevelService:get_data()
    local TYPES = BlocksDataService:get_data()

    for _, row in pairs(level_data.grid) do
        for i = 1, #row.list do
            local raw_data = row.list[i]

            for key, value in pairs(TYPES[raw_data.type]) do
                raw_data[key] = value
            end

            raw_data.grid_pos = vmath.vector3()
            raw_data.grid_pos.x = raw_data.x
            raw_data.grid_pos.y = row.y

            local id = factory.create(SceneUrls.block_factory)

            Block:new(id, raw_data)
        end
    end
end

return Factory
