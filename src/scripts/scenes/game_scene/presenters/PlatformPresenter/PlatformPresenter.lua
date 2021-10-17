local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local PlatformConfig = App.config.game.platform

--- @class PlatformPresenter
local PlatformPresenter = class('PlatformPresenter')

PlatformPresenter.__cparams = {'screen_service'}

function PlatformPresenter:initialize(screen_service, view)
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type ViewGameSceneGO
    self.view = view
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

function PlatformPresenter:delete_platform()
    self.view:delete_platform()
end

return PlatformPresenter
