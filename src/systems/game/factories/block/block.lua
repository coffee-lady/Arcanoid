local App = require('src.app')
local Components = require('src.systems.game.components.components')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local BlocksDataService = SceneServices.blocks_data
local SceneMsgService = SceneServices.msg
local SceneUrls = App.constants.urls.scenes.game_scene
local SceneMSG = App.constants.messages.game

local LevelService = Services.level

local Block = Components.block

local Factory = {}

function Factory:init()
    self.blocks = {}
    local level_data = LevelService:get_data()
    local TYPES = BlocksDataService:get_data()

    local destroyable_count = 0

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

            local block = Block:new(id, raw_data)
            self.blocks[#self.blocks + 1] = block

            if raw_data.destroyable then
                destroyable_count = destroyable_count + 1
            end
        end
    end

    SceneMsgService:on(SceneUrls.main, SceneMSG.block_destructed, function(message)
        if not message.destroyable then
            return
        end

        for i = 1, #self.blocks do
            local block = self.blocks[i]

            if block and block.id == message.id then
                table.remove(self.blocks, i)
            end
        end

        destroyable_count = destroyable_count - 1

        SceneMsgService:send(nil, SceneMSG.blocks_deleted, message)

        if destroyable_count == 0 then
            SceneMsgService:send(nil, SceneMSG.winning)
        end
    end)
end

return Factory
