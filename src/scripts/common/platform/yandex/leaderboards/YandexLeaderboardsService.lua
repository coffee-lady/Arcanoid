local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local YandexAPI = require('src.scripts.include.yandex.yandex')
local MockLeaderboards = require('src.scripts.common.platform.yandex.leaderboards.helpers.MockLeaderboards')
local PlayerHelper = require('src.scripts.common.platform.yandex.leaderboards.helpers.PlayerHelper')

local LeaderboardsAdapter = YandexAPI.Leaderboards
local AuthAdapter = YandexAPI.Auth

local LeaderboardsUseCases = UseCases.Leaderboards
local LeaderboardEntity = App.entities.LeaderboardEntity
local LeaderboardPlayerEntity = App.entities.LeaderboardPlayerEntity

local Debug = App.libs.debug
local Async = App.libs.async
local Array = App.libs.array
local Notifier = App.libs.notifier

local MSG = App.constants.msg
local LeaderboardsConfig = App.config.leaderboards
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_LAST_LOADED_PLAYER_INFO = FilesConfig.keys.last_loaded_player_leaderboard_info
local DEBUG = App.config.debug_mode.LeaderboardsService

--- @type LeaderboardsService
local YandexLeaderboardsService = {}

YandexLeaderboardsService.IMAGE_SIZE = LeaderboardsAdapter.IMAGE_SIZE

function YandexLeaderboardsService:init(services)
    --- @type StatisticsService
    self.stats_service = services.stats_service
    self.auth_service = services.auth_service
    self.player_data_storage = services.player_data_storage
    self.global_gui_caller_service = services.global_gui_caller_service

    LeaderboardsUseCases.GetLeaderboardPlayerScoreUseCase:update_services(services)
    LeaderboardsUseCases.AddPlayerLeaderboardPointsUseCase:update_services(services)
    LeaderboardsUseCases.ShowLeaderboardsTutorialUseCase:update_services(services)
    LeaderboardsUseCases.ShowLeaderboardsTutorialUseCase:set_global_callbacks()
    LeaderboardsUseCases.ShowLeaderboardsUseCase:update_services(services)

    self.score_update_notifier = Notifier(MSG.leaderboards.score_updated)
    self.debug = Debug('[Yandex] LeaderboardsService', DEBUG)

    self.is_online = true

    LeaderboardsAdapter:init_async()
    self:_update_user_score_async()

    self.global_gui_caller_service:set_callback(MSG.leaderboards._emit_score_updated, function()
        self.score_update_notifier:emit()
    end)
end

function YandexLeaderboardsService:subscribe()
    self.score_update_notifier:subscribe()
end

function YandexLeaderboardsService:unsubscribe()
    self.score_update_notifier:unsubscribe()
end

function YandexLeaderboardsService:on_authorized()
    self:_update_user_score_async()
end

function YandexLeaderboardsService:show_tutorial()
    return LeaderboardsUseCases.ShowLeaderboardsTutorialUseCase:show_tutorial()
end

function YandexLeaderboardsService:show_leaderboards()
    LeaderboardsUseCases.ShowLeaderboardsUseCase:show_leaderboards()
end

function YandexLeaderboardsService:is_available()
    return LeaderboardsUseCases.ShowLeaderboardsUseCase:is_available()
end

function YandexLeaderboardsService:on_online()
    self.is_online = true
    self:update_user_score()
end

function YandexLeaderboardsService:on_offline()
    self.is_online = false
end

function YandexLeaderboardsService:update_user_score()
    Async.bootstrap(function()
        self:_update_user_score_async()
    end)
end

function YandexLeaderboardsService:add_player_points(points)
    LeaderboardsUseCases.AddPlayerLeaderboardPointsUseCase:add_player_points(points)
end

function YandexLeaderboardsService:_update_user_score_async()
    if not self.auth_service:is_authorized() then
        self.debug:log('_update_user_score_async not authorized')
        return
    end

    local score = self:get_user_score()
    self.debug:log('_update_user_score_async', score)
    LeaderboardsAdapter:set_score_async(LeaderboardsConfig.id, score)
    self.global_gui_caller_service:call(MSG.leaderboards._emit_score_updated)
end

function YandexLeaderboardsService:get_user_score()
    return LeaderboardsUseCases.GetLeaderboardPlayerScoreUseCase:get_user_score()
end

function YandexLeaderboardsService:get_current_leaderboard_player(id)
    if not self.is_online then
        return self:_get_last_loaded_player()
    end

    local entry = LeaderboardsAdapter:get_player_entry_async(LeaderboardsConfig.id, {
        avatar_size = AuthAdapter.IMAGE_SIZE.small,
    })

    if not entry then
        return MockLeaderboards.get_dummy_current_leaderboard_player()
    end

    local player = self:_get_player_from_entry(entry)
    self:_save_last_loaded_player(player)
    return player
end

function YandexLeaderboardsService:_save_last_loaded_player(player)
    player = Array.copy_1d(player)
    player.photo = nil
    self.player_data_storage:set(FILE, KEY_LAST_LOADED_PLAYER_INFO, player)
end

function YandexLeaderboardsService:_get_last_loaded_player()
    local player = self.player_data_storage:get(FILE, KEY_LAST_LOADED_PLAYER_INFO)
    player.photo = PlayerHelper.update_player_photo(player)
    return player
end

function YandexLeaderboardsService:get_main_leaderboard_async()
    return self:get_leaderboard_async(LeaderboardsConfig.id)
end

function YandexLeaderboardsService:get_leaderboard_async(id)
    if not self.is_online then
        return nil
    end

    --- @type LeaderboardPlayerEntityPlain
    local current_player = self:get_current_leaderboard_player(id)

    local options = LeaderboardsUseCases.GetLeaderboardOptionsUseCase:get_leaderboard_options(current_player)
    options.avatar_size = AuthAdapter.IMAGE_SIZE.small
    local leaderboard_data = LeaderboardsAdapter:get_leaderboard_async(id, options)

    if not leaderboard_data then
        return MockLeaderboards.get_dummy_leaderboard(), current_player
    end

    local leaderboard = LeaderboardEntity({
        id = id,
        title = leaderboard_data.leaderboard.title,
        players = {},
    }):get_plain_data()

    self:_process_leaderboard_entries(leaderboard_data, leaderboard)

    LeaderboardsUseCases.ProcessLeaderboardUseCase:process_leaderboard(leaderboard, current_player)

    return leaderboard, current_player
end

function YandexLeaderboardsService:_process_leaderboard_entries(leaderboard_data, leaderboard)
    for i = 1, #leaderboard_data.entries do
        local entry = leaderboard_data.entries[i]
        leaderboard.players[i] = self:_get_player_from_entry(entry)
    end
end

function YandexLeaderboardsService:_get_player_from_entry(entry)
    local player = LeaderboardPlayerEntity({
        id = entry.player.uniqueID,
        name = entry.player.publicName,
        photo_url = entry.player.getAvatarSrc,
        score = entry.score,
        rank = entry.rank,
    }):get_plain_data()

    PlayerHelper.format_player_name(player)

    return player
end

function YandexLeaderboardsService:load_player_photo_async(player)
    PlayerHelper.update_player_photo(player)
    return player
end

return YandexLeaderboardsService
