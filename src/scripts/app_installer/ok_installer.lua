local App = require('src.app')
local EventBus = require('src.libs.event_bus.event_bus')
local Services = require('src.scripts.common.services.services')
local Controllers = require('src.scripts.common.controllers.controllers')
local PlayerDataStorage = require('src.scripts.common.platform.ok.player_data_storage.OKPlayerDataStorage')
local AuthService = require('src.scripts.common.platform.ok.auth.OKAuthService')
local AdsService = require('src.scripts.common.platform.ok.ads.OKAdsService')
local PaymentsService = require('src.scripts.common.platform.ok.payments.OKPaymentsService')
local StoreService = require('src.scripts.common.platform.ok.store.OKStoreService')
local OkPlatform = require('src.scripts.common.platform.ok.OkPlatformService')

local OkInstaller = {}

function OkInstaller:init()
    Services.PlatformService:set_target_platform_service(OkPlatform)
end

function OkInstaller:install(context)
    self:install_services(context)
end

function OkInstaller:install_services(context)
    context.event_bus = EventBus()
    context.ui_service = Services.UIService
    context.stats_service = Services.StatsService
    context.ranks_service = Services.RanksService
    context.scenes_service = Services.ScenesService
    context.screen_service = Services.ScreenService
    context.progress_service = Services.ProgressService
    context.localization = Services.LocalizationService
    context.local_storage = Services.LocalStorage
    context.platform_service = Services.PlatformService
    context.analytics_service = Services.AnalyticsService
    context.store_promotions_service = Services.StorePromotionsService
    context.global_gui_caller_service = Services.GlobalGUICallerService
    context.global_go_caller_service = Services.GlobalGOCallerService
    context.puzzle_generator_service = Services.PuzzleGeneratorService
    context.sound_service = Services.SoundService
    context.hints_service = Services.HintsService

    context.player_data_storage = PlayerDataStorage
    context.payments_service = PaymentsService
    context.auth_service = AuthService
    context.ads_service = AdsService
    context.store_service = StoreService

    context.puzzle_loader_service = Services.PuzzleLoaderService(context.player_data_storage)
end

return OkInstaller
