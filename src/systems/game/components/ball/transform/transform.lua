local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen

local BallConfig = App.config.game.go.ball
local PROP = App.constants.go_props

local Transform = class('Transform')

function Transform:initialize(id)
    self.id = id
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
    self.pos = vmath.vector3()
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:set_pos(pos)
    go.set_position(pos, self.id)
end

function Transform:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = BallConfig.scale * sizes.y / self.size.y

    self:set_scale(scale_factor)
end

function Transform:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + BallConfig.start_rel_pos.x * sizes.x
    self.pos.y = start_coords.y + BallConfig.start_rel_pos.y * sizes.y

    self:set_pos(self.pos)
end

return Transform
