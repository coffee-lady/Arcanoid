local App = require('src.app')

local class = App.libs.middleclass
local PlatformConfig = App.config.game.go.platform
local Observable = App.libs.event_observation.observable

local Platform = class('Platform')

function Platform:initialize()
    self.update_observer = Observable:new()
    self.bottom_padding = PlatformConfig.bottom_padding

    self:update_length(PlatformConfig.scale)
end

function Platform:update_length(rel_scale)
    if rel_scale >= PlatformConfig.min_scale and rel_scale <= PlatformConfig.max_scale then
        self.rel_scale = rel_scale
        self.update_observer:next()
    end
end

return Platform
