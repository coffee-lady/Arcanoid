local App = require('src.app')

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_ADDITIONAL_MASTERY_POINTS = DataStorageConfig.keys.additional_mastery_points

--- @class GetLeaderboardPlayerScoreUseCase
local GetLeaderboardPlayerScoreUseCase = class('GetLeaderboardPlayerScoreUseCase')

GetLeaderboardPlayerScoreUseCase.__cparams = {'player_data_storage'}

function GetLeaderboardPlayerScoreUseCase:initialize(player_data_storage)
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage
end

function GetLeaderboardPlayerScoreUseCase:get_user_score()
    local additional_points = self.player_data_storage:get(FILE, KEY_ADDITIONAL_MASTERY_POINTS) or 0
    return additional_points
end

return GetLeaderboardPlayerScoreUseCase
