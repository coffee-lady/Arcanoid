local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local StandardRanksUseCases = UseCases.Game.StandardRanksUseCases

local RanksConfig = App.config.game.ranks
local STARS_COUNT = RanksConfig.stars
local MASTER_RANK_INDEX = #RanksConfig.points + 1

local Observable = App.libs.event_observation.observable

local PERC = 100

local StandardRanksService = {}

function StandardRanksService:init(player_data_storage)
    StandardRanksUseCases:update_services(player_data_storage)

    self.on_master_rank = Observable()
end

function StandardRanksService:on_authorized()

end

function StandardRanksService:get_rank_index()
    return StandardRanksUseCases:get_rank_index()
end

function StandardRanksService:increase(delta_points)
    StandardRanksUseCases:increase_points(delta_points)

    local rank_index = self:get_rank_index()

    if rank_index == MASTER_RANK_INDEX then
        self.on_master_rank:next()
        self.on_master_rank:complete()
    end
end

function StandardRanksService:get_stars_count()
    return StandardRanksUseCases:get_stars_count()
end

function StandardRanksService:get_rank_percentage()
    local rank_index = self:get_rank_index()
    local points = StandardRanksUseCases:get_points()
    local rank_threshold = StandardRanksUseCases:get_rank_threshold(rank_index)
    return points / rank_threshold * PERC
end

return StandardRanksService
