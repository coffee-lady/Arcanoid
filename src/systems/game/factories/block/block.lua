local App = require('src.app')
local Components = require('src.systems.game.components.components')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks
local SceneMsgService = SceneServices.msg

local BlocksDataService = SceneServices.blocks_data
local SceneUrls = App.constants.urls.scenes.game_scene
local MSG = App.constants.messages

local LevelService = Services.level

local Block = Components.block

local Factory = {}

function Factory:init()
    local level_data = LevelService:get_data()
    local TYPES = BlocksDataService:get_data()

    local height = level_data.height
    local width = level_data.width

    for i = 1, height do
        for j = 1, width do
            local block_id = level_data.data[(i - 1) * width + j]

            if block_id ~= 0 then
                block_id = tostring(block_id)

                local data = {}

                for key, value in pairs(TYPES[block_id]) do
                    data[key] = value
                end

                data.grid_pos = {
                    x = j - 1,
                    y = i - 1
                }

                local id = factory.create(SceneUrls.block_factory)

                local block = Block:new(id, data)

                BlocksData:add(block)
            end
        end
    end
end

return Factory
