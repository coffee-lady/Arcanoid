local App = require('src.app')
local class = App.libs.middleclass

local Services = require('src.services.services')
local ScreenService = Services.screen

local WallView = class('WallView')

function WallView:initialize(url, rel_coords_start)
    self.id = url
    self.rel_start = rel_coords_start
    self.init_screen_sizes = ScreenService:get_sizes()
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

    go.set_position(self.pos, self.id)
end

function WallView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x > sizes.y and sizes.x / self.init_screen_sizes.x or sizes.y / self.init_screen_sizes.y

    self.scale.x = scale_factor
    self.scale.y = scale_factor
    self.scale.z = scale_factor

    go.set_scale(self.scale, self.id)
end

return WallView
