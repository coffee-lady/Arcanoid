local App = require('src.app')

local FeedbackConfig = App.config.feedback
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_WAS_FEEDBACK_REQUESTED = FilesConfig.keys.was_feedback_requested

--- @class FeedbackCanReviewUseCase
local FeedbackCanReviewUseCase = {}

function FeedbackCanReviewUseCase:update_services(services)
    self.player_data_storage = services.player_data_storage
    self.stats_service = services.stats_service
end

function FeedbackCanReviewUseCase:can_review()
    local was_feedback_requested = self.player_data_storage:get(FILE, KEY_WAS_FEEDBACK_REQUESTED)

    if was_feedback_requested then
        return false
    end

    local passed_levels = self.stats_service:get_passed_levels_count()

    if passed_levels < FeedbackConfig.start_level then
        return false
    end

    return true
end

return FeedbackCanReviewUseCase
