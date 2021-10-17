local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local PlatformConfig = App.config.game.platform
local ClickArea = PlatformConfig.click_area

--- @class PlatformPresenter
local PlatformPresenter = class('PlatformPresenter')

PlatformPresenter.__cparams = {'screen_service'}

function PlatformPresenter:initialize(screen_service, view)
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type ViewGameSceneGO
    self.view = view

    self:_update_area_coords()
end

function PlatformPresenter:reset_platform()
    self:reset_platform_pos()
    self:reset_platform_scale()
end

function PlatformPresenter:reset_platform_pos()
    local pos = vmath.vector3()
    local sizes = self.screen_service:get_sizes()
    local start_coords = self.screen_service:get_coords()

    pos.x = start_coords.x + PlatformConfig.start_rel_pos.x * sizes.x
    pos.y = start_coords.y + PlatformConfig.start_rel_pos.y * sizes.y

    self.view:set_platform_pos(pos)
end

function PlatformPresenter:reset_platform_scale()
    local platform_size = self.view:get_platform_size()
    local screen_sizes = self.screen_service:get_sizes()
    local scale_factor = PlatformConfig.scale.start * screen_sizes.x / platform_size.x
    self.view:set_platform_scale(scale_factor)
end

function PlatformPresenter:move_platform(action)
    local pos = self.screen_service:screen_to_world_2d_xy(action.screen_x, action.screen_y)

    if not Math.is_point_in_plane(pos, self.area_start, self.area_end) then
        return
    end

    local start_coords, end_coords = self:_get_platform_bounds_coords()

    pos = Math.point_in_bounds(pos, start_coords, end_coords)
    pos.y = self.view:get_platform_pos().y

    self.view:animate_platform_pos(pos)
end

function PlatformPresenter:delete_platform()
    self.view:delete_platform()
end

function PlatformPresenter:_get_platform_bounds_coords()
    local sizes = self.view:get_platform_size()
    local scale = self.view:get_platform_scale()

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
