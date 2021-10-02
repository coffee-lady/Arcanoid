local App = require('src.app')

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_ADDITIONAL_MASTERY_POINTS = FilesConfig.keys.additional_mastery_points

--- @type AddPlayerLeaderboardPointsUseCase
local AddPlayerLeaderboardPointsUseCase = {}

function AddPlayerLeaderboardPointsUseCase:update_services(services)
    self.player_data_storage = services.player_data_storage
end

function AddPlayerLeaderboardPointsUseCase:add_player_points(delta_points)
    local points = self.player_data_storage:get(FILE, KEY_ADDITIONAL_MASTERY_POINTS) or 0
    points = points + delta_points
    self.player_data_storage:set(FILE, KEY_ADDITIONAL_MASTERY_POINTS, points)
end

return AddPlayerLeaderboardPointsUseCase
