local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen

local PlatformConfig = App.config.game.go.platform
local PROP = App.constants.go_props

local Transform = class('Transform')

function Transform:initialize(id)
    self.id = id
    self.pos = vmath.vector3()
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:set_pos(pos)
    go.set_position(pos, self.id)
end

function Transform:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = PlatformConfig.scale.start * sizes.x / self.size.x

    self.scale = scale_factor

    self:set_scale(scale_factor)
end

function Transform:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * PlatformConfig.bottom_padding

    self:set_pos(self.pos)
end

return Transform
