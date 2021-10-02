local App = require('src.app')
local MCommon = require('src.scripts.common.services.business.AnalyticsService.common.common')

local String = App.libs.string
local format = String.replace_vars

local RANKS = MCommon.ranks

local ProgressionAnalyticsService = {}

function ProgressionAnalyticsService:on_player_progress(data)
    data.new_rank = RANKS[data.new_rank]

    if data.prev_rank then
        data.prev_rank = RANKS[data.prev_rank]
    end

    if data.new_rank == RANKS[1] and data.new_stars == 0 then
        return
    end

    if data.prev_rank == data.new_rank and data.prev_stars == data.new_stars then
        return
    end

    gameanalytics.addProgressionEvent({
        progressionStatus = 'Start',
        progression01 = format('{new_rank}', data),
        progression02 = format('{new_stars}', data),
    })

    if not data.prev_rank then
        return
    end

    gameanalytics.addProgressionEvent({
        progressionStatus = 'Complete',
        progression01 = format('{prev_rank}', data),
        progression02 = format('{prev_stars}', data),
    })
end

return ProgressionAnalyticsService
