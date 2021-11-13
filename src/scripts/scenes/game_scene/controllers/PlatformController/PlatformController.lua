local App = require('src.app')

local Math = App.libs.math
local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ACTION = App.constants.actions
local ID = App.constants.gui.screens.game_scene
local PlatformConfig = App.config.game.platform

--- @class PlatformController : SceneController
local PlatformController = class('PlatformController', SceneController)

PlatformController.__cparams = {'event_bus_go', 'screen_service'}

function PlatformController:initialize(event_bus, screen_service, presenters, view)
    SceneController.initialize(self, event_bus)

    --- @type ScreenService
    self.screen_service = screen_service
    --- @type PlatformPresenter
    self.platform_presenter = presenters.platform_presenter
    --- @type ViewGameSceneGO
    self.view = view

    self:set_subscriptions_map(
        {
            [ACTION.click] = self.on_click,
            [MSG.collision_response] = self.on_collision_response
        }
    )
end

function PlatformController:on_click(action)
    self:_move_platform(action)
end

function PlatformController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if go_id == hash(ID.platform) then
        print('platform collision!')
    end
end

function PlatformController:init()
    self:_reset_platform()
end

function PlatformController:_reset_platform()
    self:_reset_platform_pos()
    self:_reset_platform_scale()
end

function PlatformController:_reset_platform_pos()
    local pos = self.platform_presenter:get_platform_initial_pos()
    self.view:set_platform_pos(pos)
end

function PlatformController:_reset_platform_scale()
    local platform_size = self.view:get_platform_size()
    local scale_factor = self.platform_presenter:get_platform_scale(platform_size)
    self.view:set_platform_scale(scale_factor)
end

function PlatformController:_move_platform(action)
    local action_pos = self.platform_presenter:get_world_pos_from_action(action)

    if not self.platform_presenter:is_action_to_move_platform(action_pos) then
        return
    end

    local sizes = self.view:get_platform_size()
    local scale = self.view:get_platform_scale()
    local platform_pos = self.view:get_platform_pos()

    local start_coords, end_coords = self.platform_presenter:get_platform_bounds_coords(sizes, scale)
    local pos = self.platform_presenter:get_pos_to_move_platform(action_pos, start_coords, end_coords)
    pos.y = platform_pos.y

    self.view:animate_platform_pos(pos)
end

function PlatformController:_delete_platform()
    self.view:delete_platform()
end

return PlatformController
