local App = require('src.app')

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_ADDITIONAL_MASTERY_POINTS = DataStorageConfig.keys.additional_mastery_points

--- @type GetLeaderboardPlayerScoreUseCase
local GetLeaderboardPlayerScoreUseCase = {}

function GetLeaderboardPlayerScoreUseCase:update_services(services)
    self.player_data_storage = services.player_data_storage
end

function GetLeaderboardPlayerScoreUseCase:get_user_score()
    local additional_points = self.player_data_storage:get(FILE, KEY_ADDITIONAL_MASTERY_POINTS) or 0
    return additional_points
end

return GetLeaderboardPlayerScoreUseCase
