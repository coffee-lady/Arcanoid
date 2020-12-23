local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local Controllers = require('src.systems.game.go.controllers.controllers')
local GOSystem = require('src.common.classes.go_system')

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

local GameSceneSystem = GOSystem:new(SceneMsgService, {
    init = function()
        LevelController:init()
        BlocksController:init(LevelController:get_data())
        BallController:init()
        WallsController:init()
        PlatformController:init()
    end,

    on_input = function(action_id, action)
        PlatformController:on_input(action_id, action)
    end
})

GameSceneSystem:on({
    [MSG.game.restart] = function()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end,

    [MSG.game.winning] = function()
        timer.delay(GameConfig.delay_before_another_scene, false, function()
            ScenesService:switch_to_scene(URL.scenes.game_victory_scene.main)
        end)
    end,

    [MSG.game.losing] = function()
        ScenesService:open_popup(URL.scenes.game_losing_popup.main)
    end
})

return GameSceneSystem
