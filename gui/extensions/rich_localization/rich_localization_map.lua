local RichTextNode = require('gui.extensions.rich_text_node.rich_text_node')

local RichLocalizationMap = class('RichLocalizationMap')

-- {
--     {
--         texts_key = TextKeys.start_scene,
--         object = theme_object,
--         key = localization_key,
--         vars = {...}
--     },
-- }
function RichLocalizationMap:initialize(localization_service, texts_key, map)
    self.localization_service = localization_service
    self.texts_key = texts_key

    for i = 1, #map do
        self:add(map[i])
    end
end

function RichLocalizationMap:add(data)
    local text_data = self.localization_service:get_localized_text(self.texts_key, data.vars)
    local text = text_data[data.key]
    RichTextNode(text, data.settings)
end

return RichLocalizationMap