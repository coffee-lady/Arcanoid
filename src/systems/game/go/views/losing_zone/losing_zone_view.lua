local App = require('src.app')

local Services = require('src.services.services')
local ScreenService = Services.screen

local class = App.libs.middleclass

local LosingZoneConfig = App.config.game.go.losing_zone
local GameSceneUrls = App.constants.urls.scenes.game_scene

local LosingZoneView = class('LosingZoneView')

function LosingZoneView:initialize()
    self.url = GameSceneUrls.losing_zone
    self.sizes = ScreenService:get_sizes()
    self.pos = vmath.vector3()
    self._scale = vmath.vector3()

    self:reset_pos()
    self:reset_scale()
end

function LosingZoneView:reset()
    self:reset_pos()
    self:reset_scale()
end

function LosingZoneView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * LosingZoneConfig.bottom_padding

    go.set_position(self.pos, self.url)
end

function LosingZoneView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x / self.sizes.x

    self._scale.x = scale_factor
    self._scale.y = scale_factor
    self._scale.z = scale_factor

    go.set_scale(self._scale, self.url)
end

return LosingZoneView
