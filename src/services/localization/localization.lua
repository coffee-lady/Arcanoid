local App = require('src.app')

local ResourcesService = App.libs.resources_storage
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
        self.cache[lang] = ResourcesService:get(LocalizConfig:get_file_path(lang), LocalizConfig.file.type)
    end

    self.data = self.cache[lang]

    self.changes:next()
end

function LocalizationService:get(scene)
    return self.data[scene]
end

return LocalizationService
