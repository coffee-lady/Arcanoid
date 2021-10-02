local App = require('src.app')
local Common = require('src.scripts.common.common')
local Components = require('src.scripts.scenes.screens.start_screen.components.components')

local URL = App.constants.urls

local ComponentsController = class('ComponentsController')

function ComponentsController:initialize(context_services)
    self.components = {
        rank_widget = Components.RankWidget(context_services, true),
        navbar = Common.components.NavbarPlatform(context_services, URL.start_screen),
    }

    self.transition = Common.components.ScreenTransition()
end

function ComponentsController:update(dt)
    self.components.rank_widget:update(dt)
end

function ComponentsController:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function ComponentsController:final()
    self.transition:final()

    for _, component in pairs(self.components) do
        if component.final then
            component:final()
        end
    end
end

return ComponentsController
