local CoreServices = require('src.scripts.common.services.core.core')

local Services = {
    LocalizationService = require('src.scripts.common.services.core.LocalizationService.LocalizationService'),
    ScenesService = require('src.scripts.common.services.core.ScenesService.ScenesService'),
    ScreenService = require('src.scripts.common.services.core.ScreenService.ScreenService'),
    PlatformService = require('src.scripts.common.services.core.PlatformService.PlatformService'),
    LocalStorage = require('src.scripts.common.services.core.LocalStorage.LocalStorage'),
    GlobalGUICallerService = require('src.scripts.common.services.core.GlobalCallerServices.GlobalGUICallerService'),
    GlobalGOCallerService = require('src.scripts.common.services.core.GlobalCallerServices.GlobalGOCallerService'),
    SoundService = require('src.scripts.common.services.core.SoundService.SoundService'),
    UIService = require('src.scripts.common.services.core.UIService.UIService'),
    RanksService = require('src.scripts.common.services.game.RanksService.RanksService'),
    ConfigService = require('src.scripts.common.services.ConfigService.ConfigService'),
    ProgressService = require('src.scripts.common.services.game.ProgressService.ProgressService'),
    StatsService = require('src.scripts.common.services.game.StatisticsService.StatisticsService'),
    AnalyticsService = require('src.scripts.common.services.business.AnalyticsService.AnalyticsService'),
    StorePromotionsService = require('src.scripts.common.services.business.StorePromotionsService.StorePromotionsService'),
    PuzzleLoaderService = require('src.scripts.common.services.game.PuzzleLoaderService.PuzzleLoaderService'),
    PuzzleGeneratorService = require('src.scripts.common.services.game.PuzzleGeneratorService.PuzzleGeneratorService'),
    HintsService = require('src.scripts.common.services.game.HintsService.HintsService'),
}

return Services
