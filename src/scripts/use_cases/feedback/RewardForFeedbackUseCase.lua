local App = require('src.app')

local URL = App.constants.urls
local FeedbackConfig = App.config.feedback

--- @class RewardForFeedbackUseCase
local RewardForFeedbackUseCase = {}

function RewardForFeedbackUseCase:update_services(services)
    self.scenes_service = services.scenes_service
    self.hints_service = services.hints_service
end

function RewardForFeedbackUseCase:reward_for_review()
    self.hints_service:add_paid_hints(FeedbackConfig.reward_hints)
    self.scenes_service:switch_to_scene(URL.reward_rate_game_popup)
end

return RewardForFeedbackUseCase
