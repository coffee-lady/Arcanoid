local App = require('src.app')
local OKAPI = require('src.scripts.include.ok.ok')

local ServerConfig = App.config.server[App.config.platform]

local OkPlatformService = {}

function OkPlatformService:init(event_bus)
    OKAPI.init(event_bus, ServerConfig)
end

function OkPlatformService:on_resize()
    OKAPI.on_resize()
end

return OkPlatformService
