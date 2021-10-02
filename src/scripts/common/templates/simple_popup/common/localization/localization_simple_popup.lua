local App = require('src.app')

local Localization = class('Localization')

function Localization:initialize(context_services, nodes)
    self.localization = context_services.localization
    self.nodes = nodes
end

function Localization:update(key, is_platform_dependent, vars)
    local data
    if is_platform_dependent then
        data = self.localization:get_localized_text(App.config.platform, vars)[key]
    else
        data = self.localization:get_localized_text(key, vars)
    end

    self.nodes.title:scale_to_fit_text(data.title)
    self.nodes.text:set_text(data.text)
    self.nodes.button_next_text:scale_to_fit_text(data.button)

    if self.nodes.checkbox and data.text_checkbox then
        self.nodes.checkbox:set_text(data.text_checkbox)
    end

    if data.icon then
        self.nodes.icon:set_image(data.icon)
    end
end

return Localization
