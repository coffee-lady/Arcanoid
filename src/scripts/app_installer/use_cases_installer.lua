local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local Luject = App.libs.luject

local UseCasesInstaller = {}

function UseCasesInstaller:install_use_cases()
    Luject:bind('banner_ads_use_cases'):to(UseCases.Ads.BannerAdsUseCases):as_single()
    Luject:bind('interstitial_ads_use_cases'):to(UseCases.Ads.InterstitialAdsUseCases):as_single()
    Luject:bind('rewarded_ads_use_cases'):to(UseCases.Ads.RewardedAdsUseCases):as_single()

    Luject:bind('use_case_show_first_scene'):to(UseCases.App.ShowFirstSceneUseCase):as_single()

    Luject:bind('levels_use_cases'):to(UseCases.Game.LevelsUseCases):as_single()
    Luject:bind('energy_use_cases'):to(UseCases.Game.EnergyUseCases):as_single()
    Luject:bind('data_storage_use_cases'):to(UseCases.DataStorage):as_single()
end

return UseCasesInstaller
