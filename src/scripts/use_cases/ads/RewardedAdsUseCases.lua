local App = require('src.app')

local RewardedConfig = App.config.ads.rewarded

local RewardedAdsUseCases = {}

function RewardedAdsUseCases:update_services(stats_service)
    self.stats_service = stats_service
end

function RewardedAdsUseCases:is_available()
    local passed_levels = self.stats_service:get_passed_levels_count()
    return passed_levels >= RewardedConfig.start_level - 1
end

return RewardedAdsUseCases
