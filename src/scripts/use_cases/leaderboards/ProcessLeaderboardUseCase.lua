--- @type ProcessLeaderboardUseCase
local ProcessLeaderboardUseCase = {}

--- @param leaderboard LeaderboardEntityPlain
function ProcessLeaderboardUseCase:process_leaderboard(leaderboard, current_player)
    self:_remove_leaderboard_players_duplicates(leaderboard)
    self:_sort_leaderboard_players(leaderboard, current_player)
end

--- @param leaderboard LeaderboardEntityPlain
function ProcessLeaderboardUseCase:_sort_leaderboard_players(leaderboard, current_player)
    local players = leaderboard.players

    table.sort(players, function(playerA, playerB)
        if playerA.rank == playerB.rank and playerA.id == current_player.id then
            return false
        end

        return playerA.rank < playerB.rank
    end)
end

--- @param leaderboard LeaderboardEntityPlain
function ProcessLeaderboardUseCase:_remove_leaderboard_players_duplicates(leaderboard)
    local players = leaderboard.players

    for i = #players, 1, -1 do
        local player_id = players[i].id

        for j = 1, i - 1 do
            if players[j].id == player_id then
                table.remove(players, i)
                break
            end
        end
    end
end

return ProcessLeaderboardUseCase
