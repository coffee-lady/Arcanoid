local App = require('src.app')
local Views = require('src.systems.game.views.views')

local WallView = Views.wall

local WallsController = {}

function WallsController:init()
    self.left_wall = WallView:new('/wall_left', vmath.vector3(0, 0.5, 0))
    self.top_wall = WallView:new('/wall_top', vmath.vector3(0.5, 1, 0))
    self.right_wall = WallView:new('/wall_right', vmath.vector3(1, 0.5, 0))
    self.bottom_wall = WallView:new('/wall_bottom', vmath.vector3(0.5, 0, 0))
end

return WallsController
