local App = require('src.app')

local Difficulties = App.config.game.puzzle.difficulty

--- @class GetAllGamesStatisticsUseCases
local GetAllGamesStatisticsUseCases = {}

function GetAllGamesStatisticsUseCases:get_all_games_started_count(statistics)
    local sum = 0

    for i = 1, #Difficulties do
        local type = Difficulties[i].type
        sum = sum + self:get_type_games_started_count(statistics, type)
    end

    return sum
end

--- @param statistics StatisticsEntity
function GetAllGamesStatisticsUseCases:get_type_games_started_count(statistics, difficulty_id)
    return #statistics:get_levels_stats(difficulty_id)
end

return GetAllGamesStatisticsUseCases
