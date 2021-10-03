local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local Luject = App.libs.luject

local UseCasesInstaller = {}

function UseCasesInstaller:install_use_cases()
    Luject:bind('use_case_banner_ad'):to(UseCases.Ads.BannerAdsUseCases):as_single()
    Luject:bind('use_case_common_ads'):to(UseCases.Ads.CommonAdsUseCases):as_single()
    Luject:bind('use_case_interstitial_ad'):to(UseCases.Ads.InterstitialAdsUseCases):as_single()
    Luject:bind('use_case_rewarded_ad'):to(UseCases.Ads.RewardedAdsUseCases):as_single()
    Luject:bind('use_case_show_first_scene'):to(UseCases.App.ShowFirstSceneUseCase):as_single()
    Luject:bind('use_case_add_player_lb_points'):to(UseCases.Leaderboards.AddPlayerLeaderboardPointsUseCase):as_single()
    Luject:bind('use_case_get_lb_options'):to(UseCases.Leaderboards.GetLeaderboardOptionsUseCase):as_single()
    Luject:bind('use_case_get_lb_player_score'):to(UseCases.Leaderboards.GetLeaderboardPlayerScoreUseCase):as_single()
    Luject:bind('use_case_process_lb'):to(UseCases.Leaderboards.ProcessLeaderboardUseCase):as_single()
    Luject:bind('use_case_show_lb_tutorial'):to(UseCases.Leaderboards.ShowLeaderboardsTutorialUseCase):as_single()
    Luject:bind('use_case_show_lbs'):to(UseCases.Leaderboards.ShowLeaderboardsUseCase):as_single()
    Luject:bind('use_case_finish_special_offer'):to(UseCases.Payments.FinishOfferUseCase):as_single()
    Luject:bind('use_case_start_special_offer'):to(UseCases.Payments.StartOfferUseCase):as_single()
    Luject:bind('use_case_find_product'):to(UseCases.Payments.FindProductUseCase):as_single()
    Luject:bind('use_case_get_shown_products'):to(UseCases.Payments.GetShownProductsUseCase):as_single()
end

return UseCasesInstaller
