local App = require('src.app')

local Notifier = App.libs.notifier

local MSG = App.constants.msg

--- @class StartOfferUseCase
local StartOfferUseCase = {}

function StartOfferUseCase:update_services(context_services)
    self.global_gui_caller_service = context_services.global_gui_caller_service
    self.player_data_storage = context_services.player_data_storage
end

function StartOfferUseCase:set_global_callbacks()
    self.promotion_notifier = Notifier(MSG.store.promotion_started)

    self.global_gui_caller_service:set_callback(MSG.store._start_offer_timer, function()
        self:_start_special_offer_timer()
        self.promotion_notifier:emit()
    end)
end

--- @param store_pack StorePackEntity
function StartOfferUseCase:start_special_offer(store_pack)
    self._last_pack_offer_started = store_pack
    self.global_gui_caller_service:call(MSG.store._start_offer_timer)
end

--- @param store_pack StorePackEntity
function StartOfferUseCase:_start_special_offer_timer()
    local store_pack = self._last_pack_offer_started

    if not store_pack then
        return
    end

    local offer_timer = store_pack:get_offer_timer()
    offer_timer:resume()
end

return StartOfferUseCase
