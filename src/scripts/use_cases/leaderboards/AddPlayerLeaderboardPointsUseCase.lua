local App = require('src.app')

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_ADDITIONAL_MASTERY_POINTS = DataStorageConfig.keys.additional_mastery_points

--- @class AddPlayerLeaderboardPointsUseCase
local AddPlayerLeaderboardPointsUseCase = class('AddPlayerLeaderboardPointsUseCase')

AddPlayerLeaderboardPointsUseCase.__cparams = {'player_data_storage'}

function AddPlayerLeaderboardPointsUseCase:initialize(player_data_storage)
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage
end

function AddPlayerLeaderboardPointsUseCase:add_player_points(delta_points)
    local points = self.player_data_storage:get(FILE, KEY_ADDITIONAL_MASTERY_POINTS) or 0
    points = points + delta_points
    self.player_data_storage:set(FILE, KEY_ADDITIONAL_MASTERY_POINTS, points)
end

return AddPlayerLeaderboardPointsUseCase
