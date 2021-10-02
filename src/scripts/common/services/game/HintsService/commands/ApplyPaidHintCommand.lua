local App = require('src.app')

local URL = App.constants.urls
local MSG = App.constants.msg

local ApplyPaidHintCommand = class('ApplyPaidHintCommand')

function ApplyPaidHintCommand:initialize(context_services, hints_data_service)
    self.player_data_storage = context_services.player_data_storage
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    self.hints_data_service = hints_data_service
end

function ApplyPaidHintCommand:apply()
    self.hints_data_service:apply_paid_hint()
    self.scenes_service:post_to_gui(URL.bootstrap, MSG.actions.global_paid_hint_applied)

    return true
end

function ApplyPaidHintCommand:get_count_left()
    return self.hints_data_service:get_paid_hints()
end

function ApplyPaidHintCommand:is_available()
    return self.hints_data_service:get_paid_hints() > 0
end

return ApplyPaidHintCommand
