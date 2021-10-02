local App = require('src.app')
local MCommon = require('src.scripts.common.services.business.AnalyticsService.common.common')

local String = App.libs.string
local DateLib = App.libs.date
local Math = App.libs.math
local format = String.replace_vars

local DIFFICULTY_MASTER = 'master'
local DIFFICULTY_MASTER_LOCKED = 'master_locked'

local LOADING_SPEED_TIME = {{
    type = 'very_fast',
    bounds = {0, 3},
}, {
    type = 'fast',
    bounds = {4, 10},
}, {
    type = 'slow',
    bounds = {11, 30},
}, {
    type = 'very_slow',
    bounds = {30, math.huge},
}}

local DesignAnalyticsService = {}

function DesignAnalyticsService:init()

end

function DesignAnalyticsService:on_level_started(data)
    data.level_id = string.format('%04d', data.level_pointer or 0)

    gameanalytics.addDesignEvent({
        eventId = format('level_stats:{difficulty}:started:{level_id}', data),
    })
end

function DesignAnalyticsService:on_level_completed(data)
    data.level_id = string.format('%04d', data.level_pointer)

    gameanalytics.addDesignEvent({
        eventId = format('level_stats:{difficulty}:completed:{level_pointer}', data),
    })
    gameanalytics.addDesignEvent({
        eventId = format('level_stats:{difficulty}:hints_sum:{level_pointer}', data),
        value = data.hints_sum,
    })
    gameanalytics.addDesignEvent({
        eventId = format('level_stats:{difficulty}:mistakes_sum:{level_pointer}', data),
        value = data.mistakes_sum,
    })
    gameanalytics.addDesignEvent({
        eventId = format('level_stats:{difficulty}:time:{level_pointer}', data),
        value = Math.round(DateLib.sec_to_min(data.time)),
    })
end

function DesignAnalyticsService:on_difficulty_clicked(data, is_master_locked)
    data.rank = MCommon.ranks[data.rank]

    if data.difficulty == DIFFICULTY_MASTER and is_master_locked then
        data.difficulty = DIFFICULTY_MASTER_LOCKED
    end

    gameanalytics.addDesignEvent({
        eventId = format('difficulties_and_ranks:{rank}:{stars}:{difficulty}', data),
    })
end

function DesignAnalyticsService:on_full_mastery_sudoku_started()
    gameanalytics.addDesignEvent({
        eventId = 'full_mastery_sudoku_started',
    })
end

function DesignAnalyticsService:on_loading_screen_closed(data)
    data.time = Math.round(DateLib.msec_to_sec(data.time))

    for i = 1, #LOADING_SPEED_TIME do
        local bounds = LOADING_SPEED_TIME[i].bounds

        if data.time >= bounds[1] and data.time <= bounds[2] then
            data.time = LOADING_SPEED_TIME[i].type
            break
        end
    end

    gameanalytics.addDesignEvent({
        eventId = format('loading_speed:{time}', data),
    })
end

function DesignAnalyticsService:on_feedback_show()
    gameanalytics.addDesignEvent({
        eventId = 'rate_us_dialog:show',
    })
end

function DesignAnalyticsService:on_feedback_close()
    gameanalytics.addDesignEvent({
        eventId = 'rate_us_dialog:close',
    })
end

function DesignAnalyticsService:on_feedback_accept()
    gameanalytics.addDesignEvent({
        eventId = 'rate_us_dialog:accept',
    })
end

function DesignAnalyticsService:on_feedback_rewarded()
    gameanalytics.addDesignEvent({
        eventId = 'rate_us_dialog:rewarded',
    })
end

return DesignAnalyticsService
