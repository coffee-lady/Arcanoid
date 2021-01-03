local App = require('src.app')

local GameRes = App.config.game.resources

local ResourcesLib = App.libs.resources_storage

local BoostsDataService = {}

function BoostsDataService:init()
    self.data = ResourcesLib:get(GameRes:get_boosts_data_filepath(), GameRes.boosts_data.type)

    local default = self.data.default

    for boost_type, _ in pairs(self.data) do
        for key, value in pairs(default) do

            if self.data[boost_type][key] == nil then
                self.data[boost_type][key] = value
            end
        end
    end
end

function BoostsDataService:get_data()
    return self.data
end

return BoostsDataService
