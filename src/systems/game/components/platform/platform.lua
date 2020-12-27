local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local SceneMsgService = SceneServices.msg

local SceneUrls = App.constants.urls.scenes.game_scene
local MSG = App.constants.messages
local ACTION = App.constants.actions

local Transform = require('src.systems.game.components.platform.transform.transform')
local Animations = require('src.systems.game.components.platform.animations.animations')
local View = require('src.systems.game.components.platform.view.view')

local PlatformComponent = class('PlatformComponent')

function PlatformComponent:initialize(id)
    local transform = Transform:new(id)
    local view = View:new(id)
    local animations = Animations:new(id, transform.scale, view.size)

    transform:reset_pos()
    transform:reset_scale()

    ScreenService.update_observer:subscribe(function()
        transform:reset_pos()
        transform:reset_scale()
    end)

    SceneMsgService:on(SceneUrls.main, MSG.game.extend_platform, function(message)
        animations:animate_extension(message.percentage)
    end)

    SceneMsgService:on(SceneUrls.main, MSG.game.shorten_platform, function(message)
        animations:animate_extension(-message.percentage)
    end)

    SceneMsgService:on(SceneUrls.main, MSG.game.accelerate_platform, function(message)
        animations:accelerate_moving(message.delta_time)
    end)

    SceneMsgService:on(SceneUrls.main, MSG.game.decelerate_platform, function(message)
        animations:accelerate_moving(-message.delta_time)
    end)

    SceneMsgService:on(SceneUrls.main, ACTION.click, function(action)
        animations:animate_pos_x(action.screen_x)
    end)
end

return PlatformComponent
