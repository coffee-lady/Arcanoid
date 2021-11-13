local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local PlatformConfig = App.config.game.platform
local ClickArea = PlatformConfig.click_area

--- @class PlatformPresenter
local PlatformPresenter = class('PlatformPresenter')

PlatformPresenter.__cparams = {'screen_service'}

function PlatformPresenter:initialize(screen_service)
    --- @type ScreenService
    self.screen_service = screen_service

    self:_update_area_coords()
end

function PlatformPresenter:get_platform_initial_pos()
    local pos = vmath.vector3()
    local sizes = self.screen_service:get_sizes()
    local start_coords = self.screen_service:get_coords()

    pos.x = start_coords.x + PlatformConfig.start_rel_pos.x * sizes.x
    pos.y = start_coords.y + PlatformConfig.start_rel_pos.y * sizes.y

    return pos
end

function PlatformPresenter:get_platform_scale(platform_size)
    local screen_sizes = self.screen_service:get_sizes()
    local scale_factor = PlatformConfig.scale.start * screen_sizes.x / platform_size.x
    return scale_factor
end

function PlatformPresenter:get_world_pos_from_action(action)
    return self.screen_service:screen_to_world_2d_xy(action.screen_x, action.screen_y)
end

function PlatformPresenter:is_action_to_move_platform(pos)
    return Math.is_point_in_plane(pos, self.area_start, self.area_end)
end

function PlatformPresenter:get_pos_to_move_platform(action_pos, start_coords, end_coords)
    local pos = Math.point_in_bounds(action_pos, start_coords, end_coords)
    return pos
end

function PlatformPresenter:get_platform_bounds_coords(sizes, scale)
    local padding = sizes.x / 2 * scale.x
    local start_coords, end_coords = self.screen_service:get_coords()

    start_coords.x = start_coords.x + padding
    end_coords.x = end_coords.x - padding

    return start_coords, end_coords
end

function PlatformPresenter:_update_area_coords()
    local screen_sizes = self.screen_service:get_sizes()
    self.area_start = self.screen_service:get_coords_from_relative(ClickArea.rel_start)
    self.area_end = self.screen_service:get_coords_from_relative(ClickArea.rel_end)
end

return PlatformPresenter
