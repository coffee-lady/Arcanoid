local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

--- @class WallsPresenter
local WallsPresenter = class('WallsPresenter')

WallsPresenter.__cparams = {'screen_service'}

function WallsPresenter:initialize(screen_service)
    --- @type ScreenService
    self.screen_service = screen_service
end

function WallsPresenter:get_wall_pos(rel_pos)
    local start_coords = self.screen_service:get_coords()
    local sizes = self.screen_service:get_sizes()
    local pos = vmath.vector3()

    pos.x = start_coords.x + rel_pos.x * sizes.x
    pos.y = start_coords.y + rel_pos.y * sizes.y

    return pos
end

return WallsPresenter
