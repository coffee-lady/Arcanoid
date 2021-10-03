local App = require('src.app')

local RewardedConfig = App.config.ads.rewarded

local RewardedAdsUseCases = class('')

function RewardedAdsUseCases:initialize()
end

function RewardedAdsUseCases:is_available()
    return true
end

return RewardedAdsUseCases
