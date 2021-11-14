local App = require('src.app')
local MockLeaderboards = require('src.scripts.services.platform.yandex.leaderboards.helpers.MockLeaderboards')
local PlayerHelper = require('src.scripts.services.platform.yandex.leaderboards.helpers.PlayerHelper')
local LeaderboardsProcessor = require('src.scripts.services.platform.yandex.leaderboards.helpers.LeaderboardsProcessor')

local Array = App.libs.array

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_LAST_LOADED_PLAYER_INFO = DataStorageConfig.keys.last_loaded_player_leaderboard_info

--- @class YandexLeaderboardCurrentPlayerManager
local YandexLeaderboardCurrentPlayerManager = class('YandexLeaderboardCurrentPlayerManager')

YandexLeaderboardCurrentPlayerManager.__cparams = {
    'player_data_storage'
}

function YandexLeaderboardCurrentPlayerManager:initialize(player_data_storage)
    self.player_data_storage = player_data_storage
end

function YandexLeaderboardCurrentPlayerManager:load_current_leaderboard_player(current_player_entry)
    if not current_player_entry then
        return MockLeaderboards.get_dummy_current_leaderboard_player()
    end

    local current_player = LeaderboardsProcessor:process_player_from_entry(current_player_entry)

    self:_save_last_loaded_player(current_player)

    return current_player
end

function YandexLeaderboardCurrentPlayerManager:_save_last_loaded_player(player)
    player = Array.copy_1d(player)
    player.photo = nil
    self.player_data_storage:set(FILE, KEY_LAST_LOADED_PLAYER_INFO, player)
end

function YandexLeaderboardCurrentPlayerManager:_get_last_loaded_player()
    local player = self.player_data_storage:get(FILE, KEY_LAST_LOADED_PLAYER_INFO)
    player.photo = PlayerHelper.update_player_photo(player)
    return player
end

return YandexLeaderboardCurrentPlayerManager
