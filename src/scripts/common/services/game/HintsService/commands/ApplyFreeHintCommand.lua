local App = require('src.app')

local URL = App.constants.urls
local MSG = App.constants.msg

local ApplyFreeHintCommand = class('ApplyFreeHintCommand')

function ApplyFreeHintCommand:initialize(context_services, hints_data_service)
    self.scenes_service = context_services.scenes_service
    self.hints_data_service = hints_data_service
end

function ApplyFreeHintCommand:apply()
    self.scenes_service:post_to_gui(URL.bootstrap, MSG.actions.global_free_hint_applied)
    self.hints_data_service:apply_free_hint()
    return true
end

function ApplyFreeHintCommand:get_count_left()
    return self.hints_data_service:get_free_hints()
end

function ApplyFreeHintCommand:is_available()
    return self.hints_data_service:get_free_hints() > 0
end

return ApplyFreeHintCommand
