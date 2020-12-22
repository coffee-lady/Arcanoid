local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local Controllers = require('src.systems.game.go.controllers.controllers')

local ScenesService = Services.scenes
local SceneMsgService = GameServices.msg

local URL = App.constants.urls
local MSG = App.constants.messages

local BlocksController = Controllers.blocks
local BallController = Controllers.ball
local WallsController = Controllers.walls
local PlatformController = Controllers.platform
local LevelController = Controllers.level

local GameConfig = App.config.game

local SUBSCRIPTION = 'GAME_SCENE'

local GameSceneSystem = {}

function GameSceneSystem:init()
    LevelController:init()

    BlocksController:init(LevelController:get_data())

    BallController:init()
    WallsController:init()
    PlatformController:init()

    SceneMsgService:on(SUBSCRIPTION, MSG.game.restart, function()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end)

    SceneMsgService:on(SUBSCRIPTION, MSG.game.winning, function()
        timer.delay(GameConfig.delay_before_another_scene, false, function()
            ScenesService:switch_to_scene(URL.scenes.game_victory_scene.main)
        end)
    end)

    SceneMsgService:on(SUBSCRIPTION, MSG.game.losing, function()
        ScenesService:open_popup(URL.popups.game_losing_popup)
    end)
end

function GameSceneSystem:on_input(action_id, action)
    PlatformController:on_input(action_id, action)
end

function GameSceneSystem:on_message(message_id, message)
    SceneMsgService:send(message.receiver, message_id, message.data)
end

function GameSceneSystem:final()
    SceneMsgService:reset()
end

return GameSceneSystem
