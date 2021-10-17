local App = require('src.app')

local Math = App.libs.math
local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ACTION = App.constants.actions
local ID = App.constants.gui.screens.game_scene
local PlatformConfig = App.config.game.platform
local ClickArea = PlatformConfig.click_area

--- @class PlatformController : SceneController
local PlatformController = class('PlatformController', SceneController)

PlatformController.__cparams = {'event_bus_go', 'screen_service'}

function PlatformController:initialize(event_bus, screen_service, presenters)
    SceneController.initialize(self, event_bus)

    --- @type ScreenService
    self.screen_service = screen_service

    --- @type PlatformPresenter
    self.platform_presenter = presenters.platform_presenter

    self:set_subscriptions_map({
        [ACTION.click] = self.on_click,
    })
end

function PlatformController:init()
    self:_update_area_coords()
    self.platform_presenter:reset_platform()
end

function PlatformController:on_click(action)
    local click_coords = self.screen_service:screen_to_world_2d_xy(action.screen_x, action.screen_y)

    if not Math.is_point_in_plane(click_coords, self.area_start, self.area_end) then
        return
    end

    self.platform_presenter:animate_platform_pos_x(click_coords)
end

function PlatformController:_update_area_coords()
    local screen_sizes = self.screen_service:get_sizes()

    self.area_start = self.screen_service:get_coords_from_relative(ClickArea.rel_start)
    self.area_end = self.screen_service:get_coords_from_relative(ClickArea.rel_end)
end

return PlatformController
