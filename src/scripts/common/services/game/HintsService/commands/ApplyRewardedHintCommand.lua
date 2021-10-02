local App = require('src.app')

local URL = App.constants.urls
local MSG = App.constants.msg
local RewardedConfig = App.config.ads.rewarded

local ApplyRewardedHintCommand = class('ApplyRewardedHintCommand')

function ApplyRewardedHintCommand:initialize(context_services)
    self.ads_service = context_services.ads_service
    self.stats_service = context_services.stats_service
    self.scenes_service = context_services.scenes_service
end

function ApplyRewardedHintCommand:apply()
    local is_rewarded, is_short_view = self.ads_service:show_rewarded()

    if is_rewarded then
        self.scenes_service:post_to_gui(URL.bootstrap, MSG.actions.global_rewarded_hint_applied)
    end

    return is_rewarded, {
        is_short_view = is_short_view,
    }
end

function ApplyRewardedHintCommand:get_count_left()
    return math.huge
end

function ApplyRewardedHintCommand:is_available()
    local passed_levels = self.stats_service:get_passed_levels_count()

    return passed_levels >= RewardedConfig.start_level - 1
end

return ApplyRewardedHintCommand
