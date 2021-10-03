local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local YandexAPI = require('src.scripts.include.yandex.yandex')

local FeedbackUseCases = UseCases.Feedback
local FeedbackAdapter = YandexAPI.Feedback

local Debug = App.libs.debug

local URL = App.constants.urls
local DEBUG = App.config.debug_mode.FeedbackService
local DEBUG_LOCAL = App.config.debug_mode.FeedbackLocalVersion

--- @class FeedbackService
local YandexFeedbackService = {}

function YandexFeedbackService:init(services)
    self.scenes_service = services.scenes_service

    FeedbackUseCases.FeedbackCanReviewUseCase:update_services(services)
    FeedbackUseCases.RequestFeedbackUseCase:update_services(services)
    FeedbackUseCases.RewardForFeedbackUseCase:update_services(services)

    self.debug = Debug('[Yandex] YandexFeedbackService', DEBUG)
    self.is_online = true
end

function YandexFeedbackService:on_online()
    self.is_online = true
end

function YandexFeedbackService:on_offline()
    self.is_online = false
end

function YandexFeedbackService:_try_show_review_popup_async()
    if not self:_is_available() then
        self.debug:log('_try_show_review_popup_async unavailable')
        return
    end

    self.debug:log('requesting feedback')
    FeedbackUseCases.RequestFeedbackUseCase:request_feedback()
end

function YandexFeedbackService:request_review_async()
    if not DEBUG_LOCAL and (not self.is_online or not FeedbackAdapter:is_reviewable()) then
        self.debug:log('request_review_async unavailable')
        return false
    end

    local is_feedback_sent = FeedbackAdapter:request_review_async()

    if DEBUG_LOCAL then
        is_feedback_sent = true
    end

    self.debug:log('request_review_async is_feedback_sent', is_feedback_sent)

    if is_feedback_sent then
        self.debug:log('rewarding feedback')
        FeedbackUseCases.RewardForFeedbackUseCase:reward_for_review()
    end

    if not is_feedback_sent then
        self.debug:log('feedback was not sent')
    end

    return is_feedback_sent
end

function YandexFeedbackService:_is_available()
    if DEBUG_LOCAL then
        return true
    end

    return self.is_online and FeedbackAdapter:is_reviewable() and FeedbackUseCases.FeedbackCanReviewUseCase:can_review()
end

return YandexFeedbackService
