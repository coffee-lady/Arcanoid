local App = require('src.app')

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_ADDITIONAL_MASTERY_POINTS = FilesConfig.keys.additional_mastery_points

--- @type GetLeaderboardPlayerScoreUseCase
local GetLeaderboardPlayerScoreUseCase = {}

function GetLeaderboardPlayerScoreUseCase:update_services(services)
    --- @type StatisticsService
    self.stats_service = services.stats_service
    self.player_data_storage = services.player_data_storage
end

function GetLeaderboardPlayerScoreUseCase:get_user_score()
    local additional_points = self.player_data_storage:get(FILE, KEY_ADDITIONAL_MASTERY_POINTS) or 0
    return self.stats_service:get_all_victories_points() + additional_points
end

return GetLeaderboardPlayerScoreUseCase
