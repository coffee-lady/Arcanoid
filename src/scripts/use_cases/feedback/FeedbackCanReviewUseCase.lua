local App = require('src.app')

local FeedbackConfig = App.config.feedback
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_WAS_FEEDBACK_REQUESTED = DataStorageConfig.keys.was_feedback_requested

--- @class FeedbackCanReviewUseCase
local FeedbackCanReviewUseCase = {}

function FeedbackCanReviewUseCase:update_services(services)
    self.player_data_storage = services.player_data_storage
end

function FeedbackCanReviewUseCase:can_review()
    local was_feedback_requested = self.player_data_storage:get(FILE, KEY_WAS_FEEDBACK_REQUESTED)

    if was_feedback_requested then
        return false
    end

    return true
end

return FeedbackCanReviewUseCase
