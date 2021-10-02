local App = require('src.app')
local GetAllGamesStatisticsUseCases = require('src.scripts.use_cases.statistics.GetAllGamesStatisticsUseCases')

local Difficulties = App.config.game.puzzle.difficulty
local PERC = 100

local function get_type_config(level_type)
    for i = 1, #Difficulties do
        if Difficulties[i].type == level_type then
            return Difficulties[i]
        end
    end
end

--- @class GetAllStatisticsUseCase
local GetVictoriesStatisticsUseCases = {}

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_type_victories_count(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local count = 0

    for i = 1, #levels do
        if levels[i].is_victory then
            count = count + 1
        end
    end

    return count
end

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_type_victories_percent(statistics, difficulty_id)
    local victories_count = self:get_type_victories_count(statistics, difficulty_id)
    local finished_count = GetAllGamesStatisticsUseCases:get_type_games_started_count(statistics, difficulty_id)

    return finished_count ~= 0 and ('%.0f%%'):format(victories_count / finished_count * PERC) or 0
end

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_type_victories_without_errors(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local count = 0

    for i = 1, #levels do
        if levels[i].is_victory and levels[i].errors == 0 then
            count = count + 1
        end
    end

    return count
end

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_type_victories_points(statistics, difficulty_id)
    local config = get_type_config(difficulty_id)
    local type_points = config.points
    local victories_count = self:get_type_victories_count(statistics, difficulty_id)

    return type_points * victories_count
end

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_all_victories_points(statistics)
    local levels = statistics:get_all_levels()
    local points = 0

    for difficulty_id, _ in pairs(levels) do
        points = points + self:get_type_victories_points(statistics, difficulty_id)
    end

    return points
end

--- @param statistics StatisticsEntity
function GetVictoriesStatisticsUseCases:get_all_victories_count(statistics)
    local levels = statistics:get_all_levels()
    local count = 0

    for difficulty_id, _ in pairs(levels) do
        count = count + self:get_type_victories_count(statistics, difficulty_id)
    end

    return count
end

return GetVictoriesStatisticsUseCases
