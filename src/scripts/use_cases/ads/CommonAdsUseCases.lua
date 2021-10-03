local App = require('src.app')

local URL = App.constants.urls

--- @class CommonAdsUseCases
local CommonAdsUseCases = class('CommonAdsUseCases')

CommonAdsUseCases.__cparams = {'scenes_service'}

function CommonAdsUseCases:initialize(scenes_service)
    --- @type ScenesService
    self.scenes_service = scenes_service
end

function CommonAdsUseCases:on_ads_error()
end

return CommonAdsUseCases
