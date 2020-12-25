local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local Controllers = require('src.systems.game.go.controllers.controllers')
local GOSystem = require('src.common.classes.go_system')

local ScenesService = Services.scenes
local LevelService = Services.level
local SceneMsgService = GameServices.msg

local URL = App.constants.urls
local MSG = App.constants.messages

local BlocksController = Controllers.blocks
local BallController = Controllers.ball
local WallsController = Controllers.walls
local PlatformController = Controllers.platform
local BoostsController = Controllers.boosts

local GameSceneSystem = GOSystem:new(SceneMsgService, {
    init = function()
        local scene_data = ScenesService:get_scene_data(URL.scenes.game_scene.main)
        if scene_data and scene_data.continue then
            LevelService:go_to_new_level()
        end

        BlocksController:init()
        BallController:init()
        WallsController:init()
        PlatformController:init()
        BoostsController:init()
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
        ScenesService:switch_to_scene(URL.scenes.game_victory_scene.main)
    end,

    [MSG.game.losing] = function()
        ScenesService:open_popup(URL.scenes.game_losing_popup.main)
    end
})

return GameSceneSystem
