local App = require('src.app')

local URL = App.constants.urls

--- @class ShowOfferUseCase
local ShowOfferUseCase = {}

function ShowOfferUseCase:update_services(context_services)
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
end

function ShowOfferUseCase:show_special_offer()
    self.scenes_service:switch_to_scene(URL.starter_pack_offer_popup)
end

return ShowOfferUseCase
