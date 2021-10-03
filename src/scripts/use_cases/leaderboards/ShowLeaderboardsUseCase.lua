local App = require('src.app')

local URL = App.constants.urls
local LeaderboardsConfig = App.config.leaderboards

--- @class ShowLeaderboardsUseCase
local ShowLeaderboardsUseCase = {}

function ShowLeaderboardsUseCase:update_services(services)
    self.scenes_service = services.scenes_service
end

function ShowLeaderboardsUseCase:show_leaderboards()
    if self:is_available() then
    end
end

function ShowLeaderboardsUseCase:is_available()
    return true
end

return ShowLeaderboardsUseCase
