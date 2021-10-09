local CoreServices = require('src.scripts.services.core.core')

local Services = {
    LocalizationService = require('src.scripts.services.core.LocalizationService.LocalizationService'),
    ScenesService = require('src.scripts.services.core.ScenesService.ScenesService'),
    ScreenService = require('src.scripts.services.core.ScreenService.ScreenService'),
    PlatformService = require('src.scripts.services.core.PlatformService.PlatformService'),
    LocalStorage = require('src.scripts.services.core.LocalStorage.LocalStorage'),
    GlobalGUICallerService = require('src.scripts.services.core.GlobalCallerServices.GlobalGUICallerService'),
    GlobalGOCallerService = require('src.scripts.services.core.GlobalCallerServices.GlobalGOCallerService'),
    SoundService = require('src.scripts.services.core.SoundService.SoundService'),
    UIService = require('src.scripts.services.core.UIService.UIService'),
    ProgressService = require('src.scripts.services.game.ProgressService.ProgressService'),
    StorePromotionsService = require('src.scripts.services.business.StorePromotionsService.StorePromotionsService'),
}

return Services