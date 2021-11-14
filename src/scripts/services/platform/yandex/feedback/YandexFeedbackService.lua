local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')

local YandexFeedback = YandexAPI.YandexFeedback

local Debug = App.libs.debug

local URL = App.constants.urls
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_WAS_FEEDBACK_REQUESTED = DataStorageConfig.keys.was_feedback_requested
local DEBUG = App.config.debug_mode.FeedbackService
local DEBUG_LOCAL = App.config.debug_mode.FeedbackLocalVersion

--- @class YandexFeedbackService
local YandexFeedbackService = class('YandexFeedbackService')

YandexFeedbackService.__cparams = {'player_data_storage'}

function YandexFeedbackService:initialize(player_data_storage)
    self.player_data_storage = player_data_storage

    self.yandex_feedback = YandexFeedback()

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
    self.player_data_storage:set(FILE, KEY_WAS_FEEDBACK_REQUESTED, true)
end

function YandexFeedbackService:request_review_async()
    if not DEBUG_LOCAL and (not self.is_online or not self.yandex_feedback:is_reviewable()) then
        self.debug:log('request_review_async unavailable')
        return false
    end

    local is_feedback_sent = self.yandex_feedback:request_review_async()

    if DEBUG_LOCAL then
        is_feedback_sent = true
    end

    self.debug:log('request_review_async is_feedback_sent', is_feedback_sent)

    if is_feedback_sent then
        self.debug:log('rewarding feedback')
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

    local was_feedback_requested = self.player_data_storage:get(FILE, KEY_WAS_FEEDBACK_REQUESTED)

    if was_feedback_requested then
        return false
    end

    return self.is_online and self.yandex_feedback:is_reviewable()
end

return YandexFeedbackService
