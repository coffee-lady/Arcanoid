local App = require('src.app')

local DebugDataController = class('DebugDataController')

function DebugDataController:initialize(context_services, presenters)
    self.platform_service = context_services.platform_service
    --- @type DebugDataPresenter
    self.debug_data_presenter = presenters.debug_data

    self:_set_version_label()
end

function DebugDataController:_set_version_label()
    self.debug_data_presenter:set_version_label(self.platform_service:get_version())

    if App.config.is_release_version then
        self.debug_data_presenter:hide_version_label()
    end
end

return DebugDataController
