local App = require('src.app')
local Services = require('src.services.services')
local ScreenService = Services.screen

local class = App.libs.middleclass
local PlatformConfig = App.config.game.go.platform
local Observable = App.libs.event_observation.observable

local Platform = class('Platform')

function Platform:initialize()
    self.update_observer = Observable:new()
    self.bottom_padding = PlatformConfig.bottom_padding

    self.rel_scale = PlatformConfig.scale

    ScreenService.update_observer:subscribe(function()
        self.update_observer:next()
    end)
end

return Platform
