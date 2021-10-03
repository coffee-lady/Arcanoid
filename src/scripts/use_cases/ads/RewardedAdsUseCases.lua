local App = require('src.app')

local RewardedConfig = App.config.ads.rewarded

local RewardedAdsUseCases = {}

function RewardedAdsUseCases:update_services()
end

function RewardedAdsUseCases:is_available()
    return true
end

return RewardedAdsUseCases
