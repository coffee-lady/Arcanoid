local App = require('src.app')

local MasteryRanks = require('src.scripts.common.services.game.RanksService.MasteryRanksService')
local StandardRanks = require('src.scripts.common.services.game.RanksService.StandardRanksService')

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_RANK_INDEX = FilesConfig.keys.rank_index

local RanksConfig = App.config.game.ranks
local MASTER_RANK_INDEX = #RanksConfig.points + 1
local PERC = 100

--- @class RanksService
local RanksService = {}

function RanksService:init(player_data_storage)
    self.player_data_storage = player_data_storage

    self.ranks_service = self:_get_current_subservice()

    self.ranks_service:init(self.player_data_storage)

    if self.ranks_service == StandardRanks then
        self:_subscribe_on_master_rank()
    end
end

function RanksService:on_authorized()
    local ranks_service = self:_get_current_subservice()

    if ranks_service ~= self.ranks_service then
        ranks_service:init(self.player_data_storage)
        self.ranks_service = ranks_service
    else
        ranks_service:on_authorized()
    end

    self:_check_mastery_subscription()
end

function RanksService:_check_mastery_subscription()
    if self.ranks_service == StandardRanks and not self.master_subs then
        self:_subscribe_on_master_rank()
    elseif self.ranks_service == MasteryRanks and self.master_subs then
        self.master_subs:unsubscribe()
    end
end

function RanksService:_subscribe_on_master_rank()
    self.master_subs = StandardRanks.on_master_rank:subscribe(self, self._go_to_master)
end

function RanksService:_get_current_subservice()
    local rank_index = self.player_data_storage:get(FILE, KEY_RANK_INDEX) or 1
    return rank_index == MASTER_RANK_INDEX and MasteryRanks or StandardRanks
end

function RanksService:get_prev_data()
    return self.prev_data
end

function RanksService:get_data()
    return {
        rank_index = self.ranks_service:get_rank_index(),
        is_master = self.ranks_service == MasteryRanks,
        stars_count = self.ranks_service:get_stars_count(),
        rank_percentage = self.ranks_service:get_rank_percentage(),
    }
end

function RanksService:get_all_ranks_data()
    local current_index = self:get_rank_index()
    local data = {}

    for i = 1, current_index - 1 do
        data[#data + 1] = {
            rank_index = i,
            is_master = false,
            stars_count = RanksConfig.stars,
            percentage = PERC,
            rank_percentage = PERC,
        }
    end

    data[#data + 1] = self:get_data()

    for i = current_index + 1, MASTER_RANK_INDEX do
        data[#data + 1] = {
            rank_index = i,
            is_master = i == MASTER_RANK_INDEX,
            stars_count = 0,
            percentage = 0,
            rank_percentage = 0,
        }
    end

    return data
end

function RanksService:get_rank_index()
    return self.ranks_service:get_rank_index()
end

function RanksService:get_master_rank_index()
    return MASTER_RANK_INDEX
end

function RanksService:is_rank_master()
    return self.ranks_service == MasteryRanks
end

function RanksService:is_full_master()
    if self:is_rank_master() and MasteryRanks:is_full_master() then
        return true
    end

    return false
end

function RanksService:increase_points(points)
    self.prev_data = self:get_data()
    self.ranks_service:increase(points)
end

function RanksService:get_stars_count()
    return self.ranks_service:get_stars_count()
end

function RanksService:get_rank_percentage()
    return self.ranks_service:get_rank_percentage()
end

function RanksService:get_star_percentage()
    return self.ranks_service:get_star_percentage()
end

function RanksService:_go_to_master()
    self.ranks_service = MasteryRanks
    self.ranks_service:init(self.player_data_storage)
end

return RanksService
