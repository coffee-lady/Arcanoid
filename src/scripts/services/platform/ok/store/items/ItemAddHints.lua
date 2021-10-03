local App = require('src.app')

local ItemAddHints = class('ItemAddHints')

function ItemAddHints:initialize(context_services, key, count)
    self.player_data_storage = context_services.player_data_storage
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

end

return ItemAddHints
