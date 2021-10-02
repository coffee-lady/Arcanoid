local Services = {
    LocalizationService = require('src.scripts.common.services.core.LocalizationService.LocalizationService'),
    ScenesService = require('src.scripts.common.services.core.ScenesService.ScenesService'),
    ScreenService = require('src.scripts.common.services.core.ScreenService.ScreenService'),
    PlatformService = require('src.scripts.common.services.core.PlatformService.PlatformService'),
    LocalStorage = require('src.scripts.common.services.core.LocalStorage.LocalStorage'),
    GlobalGUICallerService = require('src.scripts.common.services.core.GlobalCallerServices.GlobalGUICallerService'),
    GlobalGOCallerService = require('src.scripts.common.services.core.GlobalCallerServices.GlobalGOCallerService'),
    SoundService = require('src.scripts.common.services.core.SoundService.SoundService'),
}

return Services
