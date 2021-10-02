local App = require('src.app')

local URL = App.constants.urls
local LeaderboardsConfig = App.config.leaderboards

--- @class ShowLeaderboardsUseCase
local ShowLeaderboardsUseCase = {}

function ShowLeaderboardsUseCase:update_services(services)
    self.scenes_service = services.scenes_service
    self.stats_service = services.stats_service
end

function ShowLeaderboardsUseCase:show_leaderboards()
    if self:is_available() then
        self.scenes_service:switch_to_scene(URL.rating_popup)
    end
end

function ShowLeaderboardsUseCase:is_available()
    local passed_levels = self.stats_service:get_all_victories_count()
    return passed_levels >= LeaderboardsConfig.level_start
end

return ShowLeaderboardsUseCase
