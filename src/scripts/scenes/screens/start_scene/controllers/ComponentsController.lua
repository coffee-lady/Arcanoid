local App = require('src.app')
local GUI = require('gui.gui')

local URL = App.constants.urls

local ComponentsController = class('ComponentsController')

function ComponentsController:initialize(context_services)
    self.transition = GUI.Transitions.ScreenTransition()
end

function ComponentsController:update(dt)

end

function ComponentsController:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function ComponentsController:final()
    self.transition:final()
end

return ComponentsController
