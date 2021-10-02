local LeaderboardsUseCases = {
    GetLeaderboardOptionsUseCase = require('src.scripts.use_cases.leaderboards.GetLeaderboardOptionsUseCase'),
    GetLeaderboardPlayerScoreUseCase = require('src.scripts.use_cases.leaderboards.GetLeaderboardPlayerScoreUseCase'),
    ProcessLeaderboardUseCase = require('src.scripts.use_cases.leaderboards.ProcessLeaderboardUseCase'),
    ShowLeaderboardsTutorialUseCase = require('src.scripts.use_cases.leaderboards.ShowLeaderboardsTutorialUseCase'),
    ShowLeaderboardsUseCase = require('src.scripts.use_cases.leaderboards.ShowLeaderboardsUseCase'),
    AddPlayerLeaderboardPointsUseCase = require('src.scripts.use_cases.leaderboards.AddPlayerLeaderboardPointsUseCase'),
}

return LeaderboardsUseCases
