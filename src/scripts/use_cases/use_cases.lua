local UseCases = {
    App = require('src.scripts.use_cases.app.app_use_cases'),
    Game = require('src.scripts.use_cases.game.game_use_cases'),
    Ads = require('src.scripts.use_cases.ads.ads_use_cases'),
    Leaderboards = require('src.scripts.use_cases.leaderboards.leaderboards_use_cases'),
    PaymentsUseCases = require('src.scripts.use_cases.payments.PaymentsUseCases'),
    Leaderboards = require('src.scripts.use_cases.leaderboards.leaderboards_use_cases'),
    DataStorage = require('src.scripts.use_cases.data_storage.DataStorageUseCases')
}

return UseCases
