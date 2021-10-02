local Ads = {
    BannerAds = require('src.scripts.include.yandex.ads.YandexBannerAdsAdapter'),
    InterstitialAds = require('src.scripts.include.yandex.ads.YandexInterstitialAdsAdapter'),
    RewardedAds = require('src.scripts.include.yandex.ads.YandexRewardedAdsAdapter'),
    RewardedAdsAlgorithm = require('src.scripts.include.yandex.ads.algorithms.YandexRewardedAdsAlgorithm'),
}

return Ads
