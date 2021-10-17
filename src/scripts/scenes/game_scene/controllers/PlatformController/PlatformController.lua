local App = require('src.app')

local SubscriptionsMap = App.libs.SubscriptionsMap
local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ID = App.constants.gui.screens.game_scene

--- @class PlatformController : SceneController
local PlatformController = class('PlatformController', SceneController)

function PlatformController:initialize(event_bus, presenters)
    SceneController.initialize(self, event_bus)

    --- @type PlatformPresenter
    self.platform_presenter = presenters.platform_presenter

    self:set_subscriptions_map({})
end

function PlatformController:init()
    self.platform_presenter:reset_platform()
end

return PlatformController
