local App = require('src.app')

local Notifier = App.libs.notifier

local MSG = App.constants.msg

--- @class FinishOfferUseCase
local FinishOfferUseCase = {}

function FinishOfferUseCase:update_services(context_services)
    self.global_gui_caller_service = context_services.global_gui_caller_service
end

function FinishOfferUseCase:set_global_callbacks()
    self.offer_finished_notifier = Notifier(MSG.store.offer_finished)

    self.global_gui_caller_service:set_callback(MSG.store._end_offer_timer, function()
        self.offer_finished_notifier:emit()
    end)
end

--- @param store_pack StorePackEntity
function FinishOfferUseCase:finish_special_offer(store_pack)
    self:cancel_offer_timer(store_pack)
    self:notify_about_timer_finished()
end

--- @param store_pack StorePackEntity
function FinishOfferUseCase:cancel_offer_timer(store_pack)
    local offer_timer = store_pack:get_offer_timer()
    offer_timer:cancel()
end

function FinishOfferUseCase:notify_about_timer_finished()
    self.global_gui_caller_service:call(MSG.store._end_offer_timer)
end

return FinishOfferUseCase
