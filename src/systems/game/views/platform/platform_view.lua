local App = require('src.app')
local class = App.libs.middleclass

local PlatformView = class('PlatformView')

local Services = require('src.services.services')
local ScreenService = Services.screen

local URLS = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props

function PlatformView:initialize(platform)
    self.platform = platform
    self.url = URLS.platform
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)

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

    self.scale = self.platform.rel_scale * sizes.x / self.size.x
    go.set_scale(self.scale, self.url)
end

function PlatformView:update_pos(pos)
    local sizes = ScreenService:get_sizes()
    local start_coords, end_coords = ScreenService:get_coords()

    if pos then
        if pos.x < start_coords.x + self.size.x * self.scale / 2 then
            pos.x = start_coords.x + self.size.x * self.scale / 2
        end

        if pos.x > end_coords.x - self.size.x * self.scale / 2 then
            pos.x = end_coords.x - self.size.x * self.scale / 2
        end

        go.set_position(pos, self.url)
        self.pos = pos
        return
    end

    self.pos = vmath.vector3(start_coords.x + sizes.x / 2, start_coords.y + sizes.y * self.platform.bottom_padding, 0)

    go.set_position(self.pos, self.url)
end

function PlatformView:on_moving_platform(action)
    self:update_pos(vmath.vector3(action.screen_x, self.pos.y, 0))
end

return PlatformView
