local YandexAdapter = require('src.scripts.include.yandex.yandex')

local YandexPlatformService = {}

function YandexPlatformService:init(event_bus)
    YandexAdapter.init(event_bus)
end

function YandexPlatformService:on_resize()

end

return YandexPlatformService
