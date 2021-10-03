local App = require('src.app')

local URL = App.constants.urls
local LeaderboardsConfig = App.config.leaderboards

--- @class ShowLeaderboardsUseCase
local ShowLeaderboardsUseCase = class('ShowLeaderboardsUseCase')

ShowLeaderboardsUseCase.__cparams = {'scenes_service'}

function ShowLeaderboardsUseCase:initialize(scenes_service)
    --- @type ScenesService
    self.scenes_service = scenes_service
end

function ShowLeaderboardsUseCase:show_leaderboards()
    if self:is_available() then
    end
end

function ShowLeaderboardsUseCase:is_available()
    return true
end

return ShowLeaderboardsUseCase
