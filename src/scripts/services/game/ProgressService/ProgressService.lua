local App = require('src.app')

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_PREV_GAME_DATA = DataStorageConfig.keys.previous_game_data

--- @class ProgressService
local ProgressService = class('ProgressService')

ProgressService.__cparams = {'player_data_storage', 'leaderboards_service'}

function ProgressService:initialize(player_data_storage, leaderboards_service)
    self.player_data_storage = player_data_storage
    self.leaderboards_service = leaderboards_service

    self.prev_game_data = self:_get_previous_game()
end

function ProgressService:on_authorized()
    self.prev_game_data = self:_get_previous_game()
end

function ProgressService:_get_previous_game()
    return self.player_data_storage:get(FILE, KEY_PREV_GAME_DATA)
end

function ProgressService:set_previous_game_data(data)
    self.prev_game_data = data
    self:save()
end

function ProgressService:set_game_data_backup(data)
    self._game_data_backup = data
end

function ProgressService:remove_previous_game_data()
    self.prev_game_data = nil
    self:save()
end

function ProgressService:get_previous_game_data()
    return self.prev_game_data
end

function ProgressService:save()
    self.player_data_storage:set(FILE, KEY_PREV_GAME_DATA, self.prev_game_data)
end

function ProgressService:get_last_game_data()
    return self._game_data_backup
end

return ProgressService
