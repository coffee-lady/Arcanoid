local App = require('src.app')

local MSG = App.constants.msg

--- @class GlobalLeaderboardsController
local GlobalLeaderboardsController = class('GlobalLeaderboardsController')

GlobalLeaderboardsController.__cparams = {
    'leaderboards_use_cases'
}

function GlobalLeaderboardsController:initialize(leaderboards_use_cases)
    --- @type LeaderboardsUseCases
    self.leaderboards_use_cases = leaderboards_use_cases
end

function GlobalLeaderboardsController:on_online()
    self.leaderboards_use_cases:update_user_score_async()
end

function GlobalLeaderboardsController:on_authorized()
    self.leaderboards_use_cases:update_user_score_async()
end

return GlobalLeaderboardsController
