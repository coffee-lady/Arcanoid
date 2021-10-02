local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local StatisticsEntity = App.entities.StatisticsEntity
local StatsUseCases = UseCases.Statistics
local DateLib = App.libs.date

local Config = App.config
local FilesConfig = Config.app
local KEY_STATS = FilesConfig.keys.statistics
local FILE = FilesConfig.file
local Difficulties = App.config.game.puzzle.difficulty

local function get_type(difficulty_id)
    if type(difficulty_id) == 'number' then
        return Difficulties[difficulty_id].type
    end

    return difficulty_id
end

--- @class StatisticsService
local StatisticsService = {}

function StatisticsService:init(player_data_storage)
    self.player_data_storage = player_data_storage
    StatsUseCases.StartGameUseCase:update_services(player_data_storage)
    StatsUseCases.FinishGameUseCase:update_services(player_data_storage)

    self.statistics = StatisticsEntity()

    self:_update_stats_data()
end

function StatisticsService:on_authorized()
    self:_update_stats_data()
end

function StatisticsService:_update_stats_data()
    local data = self.player_data_storage:get(FILE, KEY_STATS)

    if data then
        self.statistics:restore(data)
    end
end

function StatisticsService:start_game(difficulty_id)
    StatsUseCases.StartGameUseCase:start_game(self.statistics, difficulty_id)
end

function StatisticsService:finish_game(difficulty_id, is_victory, timer_data, errors_count)
    StatsUseCases.FinishGameUseCase:finish_game(self.statistics, difficulty_id, is_victory, timer_data, errors_count)
end

function StatisticsService:get_levels_statistics()
    local result = {}

    result[#result + 1] = {
        points = UseCases.Leaderboards.GetLeaderboardPlayerScoreUseCase:get_user_score(),
        days_in_game = StatsUseCases.GetTimeStatsUseCases:get_days_in_game(self.statistics),
        victories_count = StatsUseCases.GetVictoriesStatsUseCases:get_all_victories_count(self.statistics),
    }

    for i = 1, #Difficulties do
        local difficulty_id = Difficulties[i].type

        result[#result + 1] = {
            type = difficulty_id,
            games_started_count = StatsUseCases.GetAllGamesStatsUseCases:get_type_games_started_count(self.statistics, difficulty_id),
            games_finished_count = StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_count(self.statistics, difficulty_id),
            victories_percent = StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_percent(self.statistics, difficulty_id),
            best_time = StatsUseCases.GetTimeStatsUseCases:get_type_best_time(self.statistics, difficulty_id),
            average_time = StatsUseCases.GetTimeStatsUseCases:get_type_average_time(self.statistics, difficulty_id),
            current_victories_series = StatsUseCases.GetSeriesStatsUseCases:get_type_current_victories_series(self.statistics, difficulty_id),
            best_victories_series = StatsUseCases.GetSeriesStatsUseCases:get_type_best_victories_series(self.statistics, difficulty_id),
            victories_without_errors = StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_without_errors(self.statistics, difficulty_id),
        }
    end

    return result
end

function StatisticsService:get_passed_levels_count()
    return StatsUseCases.GetVictoriesStatsUseCases:get_all_victories_count(self.statistics)
end

function StatisticsService:get_all_games_started_count()
    return StatsUseCases.GetAllGamesStatsUseCases:get_all_games_started_count(self.statistics)
end

function StatisticsService:is_new_best_time_record(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetTimeStatsUseCases:is_new_best_time_record(self.statistics, difficulty_id)
end

function StatisticsService:get_days_in_game()
    return StatsUseCases.GetTimeStatsUseCases:get_days_in_game(self.statistics)
end

function StatisticsService:get_type_games_started_count(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetAllGamesStatsUseCases:get_type_games_started_count(self.statistics, difficulty_id)
end

function StatisticsService:get_type_victories_count(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_count(self.statistics, difficulty_id)
end

function StatisticsService:get_type_victories_percent(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_percent(self.statistics, difficulty_id)
end

function StatisticsService:get_type_best_time(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetTimeStatsUseCases:get_type_best_time(self.statistics, difficulty_id)
end

function StatisticsService:get_type_average_time(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetTimeStatsUseCases:get_type_average_time(self.statistics, difficulty_id)
end

function StatisticsService:get_type_current_victories_series(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetSeriesStatsUseCases:get_type_current_victories_series(self.statistics, difficulty_id)
end

function StatisticsService:get_type_best_victories_series(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetSeriesStatsUseCases:get_type_best_victories_series(self.statistics, difficulty_id)
end

function StatisticsService:get_type_victories_without_errors(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_without_errors(self.statistics, difficulty_id)
end

function StatisticsService:get_all_victories_count()
    return StatsUseCases.GetVictoriesStatsUseCases:get_all_victories_count(self.statistics)
end

function StatisticsService:get_type_victories_points(difficulty_id)
    difficulty_id = get_type(difficulty_id)
    return StatsUseCases.GetVictoriesStatsUseCases:get_type_victories_points(self.statistics, difficulty_id)
end

function StatisticsService:get_all_victories_points()
    return StatsUseCases.GetVictoriesStatsUseCases:get_all_victories_points(self.statistics)
end

return StatisticsService
