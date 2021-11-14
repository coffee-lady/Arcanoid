local App = require('src.app')
local GetLeaderboardUseCases = require('src.scripts.use_cases.leaderboards.helpers.GetLeaderboardUseCases')

local LeaderboardEntity = App.entities.LeaderboardEntity
local LeaderboardPlayerEntity = App.entities.LeaderboardPlayerEntity

local Async = App.libs.async
local Notifier = App.libs.notifier
local Luject = App.libs.luject

local MSG = App.constants.msg
local LeaderboardsConfig = App.config.leaderboards

--- @class LeaderboardsUseCases
local LeaderboardsUseCases = class('LeaderboardsUseCases')

LeaderboardsUseCases.__cparams = {
    'auth_service',
    'leaderboards_service'
}

function LeaderboardsUseCases:initialize(auth_service, leaderboards_service)
    --- @type AuthService
    self.auth_service = auth_service
    --- @type LeaderboardsService
    self.leaderboards_service = leaderboards_service

    self.get_leaderboard_use_cases = Luject:resolve_class(GetLeaderboardUseCases)

    self.score_update_notifier = Notifier(MSG.leaderboards.score_updated)

    self:update_user_score_async()

    self.global_gui_caller_service:set_callback(
        MSG.leaderboards._emit_score_updated,
        function()
            self.score_update_notifier:emit()
        end
    )
end

function LeaderboardsUseCases:subscribe()
    self.score_update_notifier:subscribe()
end

function LeaderboardsUseCases:unsubscribe()
    self.score_update_notifier:unsubscribe()
end

function LeaderboardsUseCases:update_user_score_async()
    if not self.auth_service:is_authorized() then
        return
    end

    local score = 0
    self.leaderboards_service:set_current_player_score_async(LeaderboardsConfig.id, score)

    self.global_gui_caller_service:call(MSG.leaderboards._emit_score_updated)
end

function LeaderboardsUseCases:get_main_leaderboard_current_player_async()
    local leaderboard_id = LeaderboardsConfig.id
    return self:get_leaderboard_current_player_async(leaderboard_id)
end

function LeaderboardsUseCases:get_leaderboard_current_player_async(leaderboard_id)
    return self.leaderboards_service:get_leaderboard_current_player(leaderboard_id)
end

function LeaderboardsUseCases:get_main_leaderboard_async()
    local leaderboard_id = LeaderboardsConfig.id
    return self.get_leaderboard_use_cases:get_leaderboard_async(leaderboard_id)
end

function LeaderboardsUseCases:get_leaderboard_async(leaderboard_id)
    return self.get_leaderboard_use_cases:get_leaderboard_async(leaderboard_id)
end

function LeaderboardsUseCases:load_player_photo_async(player)
    return self.leaderboards_service:load_player_photo_async(player)
end

function LeaderboardsUseCases:is_available()
    return true
end

return LeaderboardsUseCases
