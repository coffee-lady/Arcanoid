local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')
local GOSystem = require('src.common.classes.go_system')

local SharedDara = SceneServices.shared_data
local BlocksData = SharedDara.blocks
local BallsData = SharedDara.balls

local ScenesService = Services.scenes
local LevelService = Services.level
local SceneMsgService = SceneServices.msg

local BlocksDataService = SceneServices.blocks_data
local BoostsDataService = SceneServices.boosts_data
local EnergyService = Services.energy

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
        EnergyService:start_level()
        BoostsDataService:init()
        BlocksDataService:init()

        BlocksData:init()
        BallsData:init()

        local scene_data = ScenesService:get_scene_data(URL.scenes.game_scene.main)
        if scene_data and scene_data.continue then
            LevelService:go_to_new_level()
        end

        BlocksFactory:init()
        BallFactory:init()
        LosingZoneFactory:init()
        PlatformFactory:init()
        WallsFactory:init()

        BoostsFactory:init()
    end,

    on_input = function(action_id, action)
        SceneMsgService:send(nil, action_id, action)
    end,

    on_message = function(message_id, message)
        if message_id == MSG.game.increase_lives then
            SceneMsgService:post(URL.scenes.game_scene.gui, nil, message_id, message)
        end
    end
})

GameSceneSystem:on({
    [MSG.game.restart] = function()
        EnergyService:restart_level()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end,

    [MSG.game.winning] = function()
        LevelService:go_to_next_level()
        EnergyService:win_level()
        ScenesService:switch_to_scene(URL.scenes.game_victory_scene.main)
    end,

    [MSG.game.losing] = function()
        ScenesService:open_popup(URL.scenes.game_losing_popup.main)
    end
})

return GameSceneSystem
