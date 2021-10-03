local App = require('src.app')

--- @class StoreApplyProductUseCase
local StoreApplyProductUseCase = {}

function StoreApplyProductUseCase:update_services(context_services)
    --- @type PaymentsService
    self.payments_service = context_services.payments_service
end

function StoreApplyProductUseCase:apply_product(product, token)
    if product:is_consumable() then
        self.payments_service:consume_purchase_async(token)
    end
end

return StoreApplyProductUseCase
