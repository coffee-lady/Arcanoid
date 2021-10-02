local yagames = require('yagames.yagames')
local sitelock = require('yagames.sitelock')
local AdsAdapters = require('src.scripts.include.yandex.ads.ads')
local AuthAdapter = require('src.scripts.include.yandex.auth.YandexAuthAdapter')
local PlayerDataStorageAdapter = require('src.scripts.include.yandex.player_data_storage.YandexPlayerDataStorageAdapter')
local PaymentsAdapter = require('src.scripts.include.yandex.payments.YandexPaymentsAdapter')
local LeaderboardsAdapter = require('src.scripts.include.yandex.leaderboards.YandexLeaderboardsAdapter')
local FeedbackAdapter = require('src.scripts.include.yandex.feedback.YandexFeedbackAdapter')

local YandexAPI = {}

YandexAPI.Ads = AdsAdapters
YandexAPI.Auth = AuthAdapter
YandexAPI.PlayerDataStorage = PlayerDataStorageAdapter
YandexAPI.Payments = PaymentsAdapter
YandexAPI.Leaderboards = LeaderboardsAdapter
YandexAPI.Feedback = FeedbackAdapter

local function init_handler(_, err)

end

function YandexAPI.init(event_bus)
    yagames.init(init_handler)

    if html5 and sitelock.is_release_build() and not sitelock.verify_domain() then
        os.exit()
    end
end

return YandexAPI
