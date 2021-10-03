local Libs = require('src.libs.libs')

local class = Libs.middleclass

local LocalizationMap = class('LocalizationMap')

-- {
--     {
--         texts_key = TextKeys.start_scene,
--         object = theme_object,
--         key = localization_key,
--         vars = {...}
--     },
-- }
function LocalizationMap:initialize(context_services, texts_key, map)
    self.localization = context_services.localization
    self.texts_key = texts_key

    self.map = {}

    for i = 1, #map do
        self:add(map[i])
    end
end

function LocalizationMap:add(data)
    self:localize(data)
    self.map[#self.map + 1] = data
end

function LocalizationMap:localize(data)
    local text_data = self.localization:get_localized_text(self.texts_key, data.vars)
    data.object:set_text(text_data[data.key])
end

function LocalizationMap:refresh()
    for i = 1, #self.map do
        self:localize(self.map[i])
    end
end

return LocalizationMap
