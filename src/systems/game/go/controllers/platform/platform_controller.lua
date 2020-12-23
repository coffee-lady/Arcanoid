local App = require('src.app')
local Models = require('src.systems.game.go.models.models')
local Views = require('src.systems.game.go.views.views')
local Services = require('src.services.services')

local ScreenService = Services.screen

local ACTION = App.constants.actions
local Platform = Models.platform
local PlatformView = Views.platform

local PlatformController = {}

function PlatformController:init()
    self.platform = Platform:new()
    self.platform_view = PlatformView:new()

    ScreenService.update_observer:subscribe(function()
        self.platform_view:update_scale()
    end)
end

function PlatformController:on_input(action_id, action)
    if action_id == ACTION.click then
        self.platform_view:on_moving_platform(action)
    end
end

return PlatformController
