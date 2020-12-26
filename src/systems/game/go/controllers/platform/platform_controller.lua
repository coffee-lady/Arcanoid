local App = require('src.app')
local Views = require('src.systems.game.go.views.views')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local ScreenService = Services.screen
local SceneMsgService = SceneServices.msg

local ACTION = App.constants.actions
local MSG = App.constants.messages
local SceneMSG = MSG.game
local SceneUrls = App.constants.urls.scenes.game_scene
local PlatformView = Views.platform

local PlatformController = {}

function PlatformController:init()
    self.platform_view = PlatformView:new()

    ScreenService.update_observer:subscribe(function()
        self.platform_view:update_scale()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.extend_platform, function(message)
        self.platform_view:extend(message.percentage)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.shorten_platform, function(message)
        self.platform_view:extend(-message.percentage)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_platform, function(message)
        self.platform_view:accelerate(message.delta_time)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.decelerate_platform, function(message)
        self.platform_view:accelerate(-message.delta_time)
    end)
end

function PlatformController:on_input(action_id, action)
    if action_id == ACTION.click then
        self.platform_view:on_moving_platform(action)
    end
end

return PlatformController
