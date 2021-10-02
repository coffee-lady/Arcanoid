local App = require('src.app')

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_PAID_CANCELING_ERRORS = FilesConfig.keys.paid_canceling_errors_count

local ItemAddCancelingErrors = class('ItemAddCancelingErrors')

function ItemAddCancelingErrors:initialize(context_services, key, count)
    self.player_data_storage = context_services.player_data_storage
    self.count = count
    self.is_consumable = true
    self.ui_key = key
end

function ItemAddCancelingErrors:get_count()
    return self.count
end

function ItemAddCancelingErrors:get_ui_key()
    return self.ui_key
end

function ItemAddCancelingErrors:apply()
    local paid_canceling_errors_count = self.player_data_storage:get(FILE, KEY_PAID_CANCELING_ERRORS) or 0
    self.player_data_storage:set(FILE, KEY_PAID_CANCELING_ERRORS, paid_canceling_errors_count + self.count)
end

return ItemAddCancelingErrors
