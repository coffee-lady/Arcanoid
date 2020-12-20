local App = require('src.app')
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

    self:update_scale()
    self:reset_pos()
end

function PlatformView:update_scale()
    local sizes = ScreenService:get_sizes()

    self._scale = PlatformConfig.scale * sizes.x / self.size.x

    go.set_scale(self._scale, self.url)
end

function PlatformView:set_pos(pos_x)
    local start_coords, end_coords = ScreenService:get_coords()
    local min_x = start_coords.x + self.size.x * self._scale / 2
    local max_x = end_coords.x - self.size.x * self._scale / 2

    if pos_x < min_x then
        self.pos.x = min_x
    elseif pos_x > max_x then
        self.pos.x = max_x
    else
        self.pos.x = pos_x
    end

    go.set_position(self.pos, self.url)
end

function PlatformView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * PlatformConfig.bottom_padding

    go.set_position(self.pos, self.url)
end

function PlatformView:on_moving_platform(action)
    self:set_pos(action.screen_x)
end

return PlatformView
