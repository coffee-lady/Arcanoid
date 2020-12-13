local App = require('src.app')
local class = App.libs.middleclass

local Services = require('src.services.services')
local ScreenService = Services.screen

local WallView = class('WallView')

function WallView:initialize(url, rel_coords_start)
    self.rel_start = rel_coords_start
    self.url = url
    self.sizes = ScreenService:get_sizes()

    self:update()

    ScreenService.update_observer:subscribe(function()
        self:update()
    end)
end

function WallView:update()
    local start_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()

    local pos = vmath.vector3()
    pos.x = start_coords.x + self.rel_start.x * sizes.x
    pos.y = start_coords.y + self.rel_start.y * sizes.y

    local scale_factor = sizes.x > sizes.y and sizes.x / self.sizes.x or sizes.y / self.sizes.y
    local scale = vmath.vector3(scale_factor, scale_factor, scale_factor)

    go.set_position(pos, self.url)
    go.set_scale(scale, self.url)
end

return WallView
