local App = require('src.app')
local GUI = require('gui.gui')

local URL = App.constants.urls
local BannerConfig = App.config.ads.banner

local Async = App.libs.async
local Array = App.libs.array

local BANNER_SCREENS = {hash(URL.start_scene)}

--- @class BannerAdsUseCases
local BannerAdsUseCases = {}

function BannerAdsUseCases:update_services(context_services)
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    self.ads_service = context_services.ads_service
end

function BannerAdsUseCases:close_banner()
    self.scenes_service:post_to_go(App.constants.urls.bootstrap, GUI.BUTTON_CLICKED)
end

function BannerAdsUseCases:try_show_banner(scenes_data)
    Async.bootstrap(function()
        local current_scene = self:_get_current_scene(scenes_data)

        if Array.has(current_scene, BANNER_SCREENS) then
            self.ads_service:show_banner()
        end
    end)
end

function BannerAdsUseCases:try_hide_banner(scenes_data)
    Async.bootstrap(function()
        local current_scene = self:_get_current_scene(scenes_data)

        if not Array.has(current_scene, BANNER_SCREENS) then
            self.ads_service:hide_banner()
        end
    end)
end

function BannerAdsUseCases:_get_current_scene(scenes_data)
    return scenes_data and scenes_data.current_scene or self.scenes_service:get_current_scene()
end

function BannerAdsUseCases:is_available()
    return true
end

return BannerAdsUseCases
