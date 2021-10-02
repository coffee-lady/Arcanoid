local App = require('src.app')
local GetAllGamesStatisticsUseCases = require('src.scripts.use_cases.statistics.GetAllGamesStatisticsUseCases')

local FilesConfig = App.config.app
local KEY_STATS = FilesConfig.keys.statistics
local FILE = FilesConfig.file

--- @class StatisticsStartGameUseCase
local StatisticsStartGameUseCase = {}

function StatisticsStartGameUseCase:update_services(player_data_storage)
    self.player_data_storage = player_data_storage
end

--- @param statistics StatisticsEntity
function StatisticsStartGameUseCase:start_game(statistics, difficulty_id)
    statistics:start_game(difficulty_id)
    self.player_data_storage:set(FILE, KEY_STATS, statistics:get_plain_data())
end

return StatisticsStartGameUseCase
