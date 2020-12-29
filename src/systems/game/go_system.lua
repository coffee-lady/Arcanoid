local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local GOSystem = require('src.common.classes.go_system')

local ScenesService = Services.scenes
local LevelService = Services.level
local SceneMsgService = SceneServices.msg
local BlocksDataService = SceneServices.blocks_data

local URL = App.constants.urls
local MSG = App.constants.messages

local Factories = require('src.systems.game.factories.factories')
local BallFactory = Factories.ball
local BlocksFactory = Factories.block
local LosingZoneFactory = Factories.losing_zone
local PlatformFactory = Factories.platform
local WallsFactory = Factories.wall
local BoostsFactory = Factories.boost

local GameSceneSystem = GOSystem:new(SceneMsgService, {
    init = function()
        BlocksDataService:init()

        local scene_data = ScenesService:get_scene_data(URL.scenes.game_scene.main)
        if scene_data and scene_data.continue then
            LevelService:go_to_new_level()
        end

        BlocksFactory:init()
        BallFactory:init()
        LosingZoneFactory:init()
        PlatformFactory:init()
        WallsFactory:init()

        BoostsFactory:init(BlocksFactory.blocks)
    end,

    on_input = function(action_id, action)
        SceneMsgService:send(nil, action_id, action)
    end
})

GameSceneSystem:on({
    [MSG.game.restart] = function()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end,

    [MSG.game.winning] = function()
        LevelService:go_to_next_level()
        ScenesService:switch_to_scene(URL.scenes.game_victory_scene.main)
    end,

    [MSG.game.losing] = function()
        ScenesService:open_popup(URL.scenes.game_losing_popup.main)
    end
})

return GameSceneSystem
