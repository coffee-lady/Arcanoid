local App = require('src.app')

local PaymentsConfig = App.config.payments
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local STARTER_PACK_REPLACER_ID = PaymentsConfig.starter_pack_replacer_id

--- @class StoreGetShownProductsUseCase
local StoreGetShownProductsUseCase = {}

function StoreGetShownProductsUseCase:update_services(context_services)
    --- @type PaymentsService
    self.payments_service = context_services.payments_service
end

function StoreGetShownProductsUseCase:get_products_to_show(shop_catalog)
    local is_starter_pack_bought = self.payments_service:has_in_purchase_list(STARTER_PACK_ID)
    local packs_to_show = {}

    for i = 1, #shop_catalog do
        local pack_data = shop_catalog[i]
        self:_check_product_to_add_in_showing(pack_data, is_starter_pack_bought, packs_to_show)
    end

    return packs_to_show
end

function StoreGetShownProductsUseCase:_check_product_to_add_in_showing(product, is_starter_pack_bought, packs_to_show)
    local id = product:get_id()

    if is_starter_pack_bought and id == STARTER_PACK_ID then
        return
    end

    if not is_starter_pack_bought and id == STARTER_PACK_REPLACER_ID then
        return
    end

    packs_to_show[#packs_to_show + 1] = product
end

return StoreGetShownProductsUseCase
