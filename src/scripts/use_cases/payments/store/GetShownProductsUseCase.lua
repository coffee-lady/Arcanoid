local App = require('src.app')

local PaymentsConfig = App.config.payments

--- @class GetShownProductsUseCase
local GetShownProductsUseCase = class('GetShownProductsUseCase')

GetShownProductsUseCase.__cparams = {'payments_service'}

function GetShownProductsUseCase:initialize(payments_service)
    --- @type PaymentsService
    self.payments_service = payments_service
end

function GetShownProductsUseCase:get_products_to_show(shop_catalog)
    local packs_to_show = {}

    for i = 1, #shop_catalog do
        local pack_data = shop_catalog[i]
        self:_check_product_to_add_in_showing(pack_data, packs_to_show)
    end

    return packs_to_show
end

function GetShownProductsUseCase:_check_product_to_add_in_showing(product, packs_to_show)
    local id = product:get_id()
    packs_to_show[#packs_to_show + 1] = product
end

return GetShownProductsUseCase
