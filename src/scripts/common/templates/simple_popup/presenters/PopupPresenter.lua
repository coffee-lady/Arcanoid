local App = require('src.app')

local PopupPresenter = class('PopupPresenter')

function PopupPresenter:initialize(context_services, view)
    self.view = view
    self.view:update_layout()
end

function PopupPresenter:add_checkbox(checkbox)
    self.view:add_checkbox(checkbox:get_container())
    self.has_checkbox = true
    self.view:update_layout_with_checkbox()
end

function PopupPresenter:update_layout()
    if self.has_checkbox then
        self.view:update_layout_with_checkbox()
    else
        self.view:update_layout()
    end
end

return PopupPresenter
