local App = require('src.app')

local PacksConfig = App.config.game.packs

local PackData = {}

function PackData:load_pack_by_level(level)
    self.current_pack = self:get_pack(level)
end

function PackData:get_current_pack()
    return self.current_pack
end

function PackData:get_pack(level)
    for i = 1, #PacksConfig.list do
        local first_level = PacksConfig.list[i].first_level
        local last_level = PacksConfig.list[i].last_level

        if first_level <= level and last_level >= level then
            return PacksConfig.list[i]
        end
    end
end

function PackData:get_last_level()
    return PacksConfig.list[#PacksConfig.list].last_level
end

return PackData
