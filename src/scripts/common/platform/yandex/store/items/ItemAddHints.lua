local App = require('src.app')

local ItemAddHints = class('ItemAddHints')

function ItemAddHints:initialize(context_services, key, count)
    self.hints_service = context_services.hints_service

    self.count = count
    self.is_consumable = true
    self.ui_key = key
end

function ItemAddHints:get_count()
    return self.count
end

function ItemAddHints:get_ui_key()
    return self.ui_key
end

function ItemAddHints:apply()
    self.hints_service:add_paid_hints(self.count)
end

return ItemAddHints
