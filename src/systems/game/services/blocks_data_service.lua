local App = require('src.app')

local GameRes = App.config.game.resources

local ResourcesLib = App.libs.resources_storage

local BlocksDataService = {}

function BlocksDataService:init()
    self.data = ResourcesLib:get(GameRes:get_blocks_data_filepath(), GameRes.blocks_data.type)

    local default = self.data.default

    for block_type, _ in pairs(self.data) do
        for key, value in pairs(default) do

            if self.data[block_type][key] == nil then
                self.data[block_type][key] = value
            end
        end
    end
end

function BlocksDataService:get_data()
    return self.data
end

return BlocksDataService
