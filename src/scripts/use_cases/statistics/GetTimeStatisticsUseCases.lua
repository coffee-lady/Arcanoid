local App = require('src.app')

local Date = App.libs.date
local Difficulties = App.config.game.puzzle.difficulty

--- @class GetTimeStatisticsUseCases
local GetTimeStatisticsUseCases = {}

--- @param statistics StatisticsEntity
function GetTimeStatisticsUseCases:is_new_best_time_record(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local levels_count = #levels

    if levels_count < 2 then
        return false
    end

    local best_time = levels[levels_count].time

    for i = 1, #levels - 1 do
        if levels[i].is_finished and levels[i].time <= best_time then
            return false
        end
    end

    return true
end

function GetTimeStatisticsUseCases:get_days_in_game(statistics)
    return math.ceil(Date.get_days(os.time() - statistics:get_first_start_time()))
end

--- @param statistics StatisticsEntity
function GetTimeStatisticsUseCases:get_type_best_time(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)

    if #levels == 0 then
        return Date.format_ms_from_s(0)
    end

    local best_time

    for i = 1, #levels do
        if (not best_time and levels[i].is_victory) or (best_time and levels[i].is_victory and levels[i].time < best_time) then
            best_time = levels[i].time
        end
    end

    return Date.format_ms_from_s(best_time and best_time or 0), best_time
end

--- @param statistics StatisticsEntity
function GetTimeStatisticsUseCases:get_type_average_time(statistics, difficulty_id)
    local levels = statistics:get_levels_stats(difficulty_id)
    local all_time = 0
    local count = 0

    for i = 1, #levels do
        if levels[i].is_victory then
            all_time = all_time + levels[i].time
            count = count + 1
        end
    end

    local average_time = count ~= 0 and all_time / count or 0

    return Date.format_ms_from_s(average_time)
end

return GetTimeStatisticsUseCases
