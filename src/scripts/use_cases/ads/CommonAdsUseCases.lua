local App = require('src.app')

local URL = App.constants.urls

--- @class CommonAdsUseCases
local CommonAdsUseCases = {}

function CommonAdsUseCases:update_services(context_services)
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
end

function CommonAdsUseCases:on_ads_error()
end

return CommonAdsUseCases
