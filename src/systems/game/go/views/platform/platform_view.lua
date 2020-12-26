local App = require('src.app')
local Animation = require('src.systems.game.go.views.platform.animation.animation')
local class = App.libs.middleclass

local PlatformView = class('PlatformView')
local PlatformConfig = App.config.game.go.platform

local Services = require('src.services.services')
local ScreenService = Services.screen

local URLS = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props

function PlatformView:initialize()
    self.url = URLS.platform
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)
    self.pos = vmath.vector3()
    self.moving_duration = PlatformConfig.moving_duration.start

    self:update_scale()
    self:reset_pos()

    Animation:init(self.url)
end

function PlatformView:update_scale()
    local sizes = ScreenService:get_sizes()

    self.scale = PlatformConfig.scale.start * sizes.x / self.size.x

    go.set_scale(self.scale, self.url)
end

function PlatformView:extend(p)
    local sizes = ScreenService:get_sizes()

    local scale = self.scale + p * sizes.x / self.size.x

    if scale < PlatformConfig.scale.min or scale > PlatformConfig.scale.max then
        return
    end

    self.scale = scale
    Animation:animate_scale(self.scale)
end

function PlatformView:accelerate(delta_time)
    self.moving_duration = self.moving_duration + delta_time

    if self.moving_duration < PlatformConfig.moving_duration.min or self.moving_duration >
        PlatformConfig.moving_duration.max then
        self.moving_duration = self.moving_duration - delta_time
    end
end

function PlatformView:set_pos_x(pos_x)
    local start_coords, end_coords = ScreenService:get_coords()
    local min_x = start_coords.x + self.size.x * self.scale / 2
    local max_x = end_coords.x - self.size.x * self.scale / 2

    if pos_x < min_x then
        self.pos.x = min_x
    elseif pos_x > max_x then
        self.pos.x = max_x
    else
        self.pos.x = pos_x
    end
end

function PlatformView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * PlatformConfig.bottom_padding

    go.set_position(self.pos, self.url)
end

function PlatformView:on_moving_platform(action)
    self:set_pos_x(action.screen_x)

    Animation:animate_pos_x(self.pos, self.moving_duration)
end

return PlatformView
