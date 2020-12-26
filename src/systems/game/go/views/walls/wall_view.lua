local App = require('src.app')
local class = App.libs.middleclass

local Services = require('src.services.services')
local ScreenService = Services.screen

local WallView = class('WallView')

function WallView:initialize(url, rel_coords_start)
    self.url = url
    self.rel_start = rel_coords_start
    self.sizes = ScreenService:get_sizes()
    self.scale = vmath.vector3()
    self.pos = vmath.vector3()

    self:reset()
end

function WallView:reset()
    self:reset_pos()
    self:reset_scale()
end

function WallView:reset_pos()
    local start_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()

    self.pos.x = start_coords.x + self.rel_start.x * sizes.x
    self.pos.y = start_coords.y + self.rel_start.y * sizes.y

    go.set_position(self.pos, self.url)
end

function WallView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x > sizes.y and sizes.x / self.sizes.x or sizes.y / self.sizes.y

    self.scale.x = scale_factor
    self.scale.y = scale_factor
    self.scale.z = scale_factor

    go.set_scale(self.scale, self.url)
end

return WallView
