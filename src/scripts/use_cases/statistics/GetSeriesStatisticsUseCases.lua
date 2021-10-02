local App = require('src.app')

local Difficulties = App.config.game.puzzle.difficulty

--- @class GetAllStatisticsUseCase
local GetSeriesStatisticsUseCases = {}

--- @param statistics StatisticsEntity
function GetSeriesStatisticsUseCases:get_type_current_victories_series(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local count = 0

    if #levels == 0 then
        return count
    end

    if levels[#levels].is_victory then
        count = count + 1
    end

    for i = #levels - 1, 1, -1 do
        if levels[i].is_victory then
            count = count + 1
        else
            return count
        end
    end

    return count
end

--- @param statistics StatisticsEntity
function GetSeriesStatisticsUseCases:get_type_best_victories_series(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local series = {0}

    if #levels == 0 then
        return 0
    end

    if levels[#levels].is_victory then
        series[#series] = series[#series] + 1
    end

    for i = #levels - 1, 1, -1 do
        if levels[i].is_victory then
            series[#series] = series[#series] + 1
        else
            series[#series + 1] = 0
        end
    end

    local best_series = 0

    for i = 1, #series do
        if series[i] > best_series then
            best_series = series[i]
        end
    end

    return best_series
end

return GetSeriesStatisticsUseCases
