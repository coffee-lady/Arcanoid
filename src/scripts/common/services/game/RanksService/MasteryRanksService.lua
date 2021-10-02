local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local MasteryRankUseCases = UseCases.Game.MasteryRankUseCases

local MasteryConfig = App.config.game.ranks.mastery
local PERC = 100

local MasteryRanksService = {}

function MasteryRanksService:init(player_data_storage)
    MasteryRankUseCases:update_services(player_data_storage)

    self:_update_timer()
end

function MasteryRanksService:on_authorized()
    self:_update_timer()
end

function MasteryRanksService:_update_timer()
    if self.timer then
        self.timer:cancel()
    end

    self.timer = MasteryRankUseCases:set_master_points_timer()
end

function MasteryRanksService:get_rank_index()
    return MasteryRankUseCases:get_rank_index()
end

function MasteryRanksService:increase(delta_points)
    MasteryRankUseCases:increase_points(delta_points)
end

function MasteryRanksService:is_full_master()
    return MasteryRankUseCases:get_points() > MasteryConfig.points
end

function MasteryRanksService:get_rank_percentage()
    local points = MasteryRankUseCases:get_points()

    if points > MasteryConfig.points then
        return PERC
    end

    return points / MasteryConfig.points * PERC
end

function MasteryRanksService:get_stars_count()
    return MasteryRankUseCases:get_stars_count()
end

return MasteryRanksService
