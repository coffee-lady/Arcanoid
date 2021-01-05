local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local LosingZoneConfig = App.config.game.go.losing_zone

local Transform = class('Transform')

function Transform:initialize(id)
    self.id = id
    self.pos = vmath.vector3()
    self.init_screen_sizes = ScreenService:get_sizes()
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:set_pos(pos)
    go.set_position(pos, self.id)
end

function Transform:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * LosingZoneConfig.bottom_padding

    self:set_pos(self.pos)
end

function Transform:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x / self.init_screen_sizes.x

    self:set_scale(scale_factor)
end

return Transform
