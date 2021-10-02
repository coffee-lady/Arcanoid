local StatisticsUseCases = {
    GetAllGamesStatsUseCases = require('src.scripts.use_cases.statistics.GetAllGamesStatisticsUseCases'),
    GetSeriesStatsUseCases = require('src.scripts.use_cases.statistics.GetSeriesStatisticsUseCases'),
    GetTimeStatsUseCases = require('src.scripts.use_cases.statistics.GetTimeStatisticsUseCases'),
    GetVictoriesStatsUseCases = require('src.scripts.use_cases.statistics.GetVictoriesStatisticsUseCases'),
    FinishGameUseCase = require('src.scripts.use_cases.statistics.StatisticsFinishGameUseCase'),
    StartGameUseCase = require('src.scripts.use_cases.statistics.StatisticsStartGameUseCase'),
}

return StatisticsUseCases
