local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local PlatformView = class('PlatformView')

function PlatformView:initialize(id)
    self.id = id
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
    self.pos = vmath.vector3()
end

function PlatformView:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function PlatformView:set_pos(pos)
    go.set_position(pos, self.id)
end

function PlatformView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = PlatformConfig.scale.start * sizes.x / self.size.x

    self.scale = scale_factor

    self:set_scale(scale_factor)
end

function PlatformView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * PlatformConfig.bottom_padding

    self:set_pos(self.pos)
end

function PlatformView:animate_extension(percentage)

end

function PlatformView:accelerate_moving(delta_time)

end

function PlatformView:animate_pos_x(x)

end

return PlatformView
