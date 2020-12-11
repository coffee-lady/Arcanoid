local App = require('src.app')

local LocalizConfig = App.config.localization
local Observable = App.libs.event_observation.observable

local LocalizationService = {}

function LocalizationService:init(lang)
    self.cache = {}
    self.changes = Observable:new()

    self:change(lang)
end

function LocalizationService:change(lang)
    if not self.cache[lang] then
        local json_data = sys.load_resource(LocalizConfig:get_resource_path(lang))
        self.cache[lang] = json.decode(json_data)
    end

    self.data = self.cache[lang]

    self.changes:next()
end

return LocalizationService
