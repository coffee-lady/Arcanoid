local App = require('src.app')
local EventBus = require('src.libs.event_bus.event_bus')
local Services = require('src.scripts.common.services.services')
local PlayerDataStorage = require('src.scripts.common.platform.yandex.player_data_storage.YandexPlayerDataStorage')
local AuthService = require('src.scripts.common.platform.yandex.auth.YandexAuthService')
local AdsService = require('src.scripts.common.platform.yandex.ads.YandexAdsService')
local PaymentsService = require('src.scripts.common.platform.yandex.payments.YandexPaymentsService')
local StoreService = require('src.scripts.common.platform.yandex.store.YandexStoreService')
local LeaderboardsService = require('src.scripts.common.platform.yandex.leaderboards.YandexLeaderboardsService')
local FeedbackService = require('src.scripts.common.platform.yandex.feedback.YandexFeedbackService')
local YandexPlatformService = require('src.scripts.common.platform.yandex.YandexPlatformService')

local YandexInstaller = {}

function YandexInstaller:init()
    Services.PlatformService:set_target_platform_service(YandexPlatformService)
end

function YandexInstaller:install(context)
    self:install_services(context)
end

function YandexInstaller:install_services(context)
    context.event_bus = EventBus()
    context.ui_service = Services.UIService
    context.scenes_service = Services.ScenesService
    context.screen_service = Services.ScreenService
    context.progress_service = Services.ProgressService
    context.localization = Services.LocalizationService
    context.local_storage = Services.LocalStorage
    context.platform_service = Services.PlatformService
    context.store_promotions_service = Services.StorePromotionsService
    context.global_gui_caller_service = Services.GlobalGUICallerService
    context.global_go_caller_service = Services.GlobalGOCallerService
    context.sound_service = Services.SoundService

    context.player_data_storage = PlayerDataStorage
    context.payments_service = PaymentsService
    context.auth_service = AuthService
    context.ads_service = AdsService
    context.store_service = StoreService
    context.leaderboards_service = LeaderboardsService
    context.feedback_service = FeedbackService
end

return YandexInstaller
