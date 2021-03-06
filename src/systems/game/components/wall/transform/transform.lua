local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local WallConfig = App.config.game.go.walls

local Transform = class('Transform')

function Transform:initialize(key, id)
    self.id = id
    self.key = key
    self.pos = vmath.vector3()
    self.init_screen_sizes = ScreenService:get_sizes()
end

function Transform:reset()
    self:reset_pos()
    self:reset_scale()
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:set_pos(pos)
    go.set_position(pos, self.id)
end

function Transform:reset_pos()
    local start_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()
    local config = WallConfig[self.key]

    self.pos.x = start_coords.x + config.pos.x * sizes.x
    self.pos.y = start_coords.y + config.pos.y * sizes.y

    self:set_pos(self.pos)
end

function Transform:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x > sizes.y and sizes.x / self.init_screen_sizes.x or sizes.y / self.init_screen_sizes.y

    self:set_scale(scale_factor)
end

return Transform
