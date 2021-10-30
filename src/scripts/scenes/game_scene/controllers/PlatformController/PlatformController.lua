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

function PlatformController:initialize(event_bus, screen_service, presenters)
    SceneController.initialize(self, event_bus)

    --- @type ScreenService
    self.screen_service = screen_service

    --- @type PlatformPresenter
    self.platform_presenter = presenters.platform_presenter

    self:set_subscriptions_map({
        [ACTION.click] = self.on_click,
        [MSG.collision_response] = self.on_collision_response
    })
end

function PlatformController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if go_id == hash(ID.platform) then
        print('platform collision!')
    end
end

function PlatformController:init()
    self.platform_presenter:reset_platform()
end

function PlatformController:on_click(action)
    self.platform_presenter:move_platform(action)
end

return PlatformController
