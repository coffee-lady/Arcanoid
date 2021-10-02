local App = require('src.app')
local GetAllGamesStatisticsUseCases = require('src.scripts.use_cases.statistics.GetAllGamesStatisticsUseCases')

local FilesConfig = App.config.app
local KEY_STATS = FilesConfig.keys.statistics
local FILE = FilesConfig.file

--- @class StatisticsFinishGameUseCase
local StatisticsFinishGameUseCase = {}

function StatisticsFinishGameUseCase:update_services(player_data_storage)
    self.player_data_storage = player_data_storage
end

--- @param statistics StatisticsEntity
function StatisticsFinishGameUseCase:finish_game(statistics, difficulty_id, is_victory, timer_data, errors_count)
    statistics:finish_game(difficulty_id, is_victory, timer_data, errors_count)
    self.player_data_storage:set(FILE, KEY_STATS, statistics:get_plain_data())
end

return StatisticsFinishGameUseCase
