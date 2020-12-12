local App = require('src.app')
local class = App.libs.middleclass

local PlatformView = class('PlatformView')

local Services = require('src.services.services')
local ScreenService = Services.screen

function PlatformView:initialize(platform)
    self.platform = platform
    self.url = '/platform'
    self.size = go.get(msg.url(nil, self.url, 'sprite'), 'size')

    self.platform.update_observer:subscribe(function()
        self:update_velocity()
    end)

    ScreenService.observer:subscribe(function()
        self:update_scale()
        self:update_pos()
    end)

    self:update_scale()
    self:update_pos()
end

function PlatformView:update_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((self.platform.rel_scale * sizes.x) / self.size.x, self.url)
end

function PlatformView:update_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    go.set_position(
        vmath.vector3(start_coords.x + sizes.x / 2, start_coords.y + sizes.y * self.platform.bottom_padding, 0),
        self.url)
end

return PlatformView
