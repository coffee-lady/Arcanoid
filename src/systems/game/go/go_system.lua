local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local Controllers = require('src.systems.game.go.controllers.controllers')
local GOSystem = require('src.common.classes.go_system')

local ScenesService = Services.scenes
local LevelService = Services.level
local SceneMsgService = SceneServices.msg
local BlocksDataService = SceneServices.blocks_data

local URL = App.constants.urls
local MSG = App.constants.messages

local WallsController = Controllers.walls
local PlatformController = Controllers.platform
local BoostsController = Controllers.boosts

local Factories = require('src.systems.game.factories.factories')
local BallFactory = Factories.ball
local BlocksFactory = Factories.block
local LosingZoneFactory = Factories.losing_zone

local GameSceneSystem = GOSystem:new(SceneMsgService, {
    init = function()
        BlocksDataService:init()

        local scene_data = ScenesService:get_scene_data(URL.scenes.game_scene.main)
        if scene_data and scene_data.continue then
            LevelService:go_to_new_level()
        end

        -- BlocksController:init()
        BlocksFactory:init()
        BallFactory:init()
        LosingZoneFactory:init()

        WallsController:init()
        PlatformController:init()
        -- BoostsController:init()
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
