--- @class FindProductUseCase
local FindProductUseCase = class('FindProductUseCase')

function FindProductUseCase.static:find_product(product_id, shop_catalog)
    for i = 1, #shop_catalog do
        local product = shop_catalog[i]
        local item_id = product:get_id()
        local item_offer_id = product:get_offer_id()

        if item_id == product_id or item_offer_id == product_id then
            return product
        end
    end
end

return FindProductUseCase
