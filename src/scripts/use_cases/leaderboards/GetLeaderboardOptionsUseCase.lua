local App = require('src.app')

local LeaderboardsConfig = App.config.leaderboards

--- @type GetLeaderboardOptionsUseCase
local GetLeaderboardOptionsUseCase = {}

--- @param current_player LeaderboardPlayerEntityPlain
function GetLeaderboardOptionsUseCase:get_leaderboard_options(current_player)
    local player_rank = current_player.rank
    local options = {
        include_user = true,
    }

    local AMOUNT_TOP = LeaderboardsConfig.top_count_by_player
    local AMOUNT_AROUND = LeaderboardsConfig.around_player_count

    if player_rank <= AMOUNT_TOP + AMOUNT_AROUND + 1 then
        options.amount_top = player_rank
        options.amount_around = math.max(AMOUNT_TOP - player_rank, AMOUNT_AROUND)
    else
        options.amount_top = AMOUNT_TOP
        options.amount_around = AMOUNT_AROUND
    end

    return options
end

return GetLeaderboardOptionsUseCase
