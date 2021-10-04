local Luject = require('src.libs.luject.luject')
local ScriptWrapper = require('src.libs.script_wrapper.ScriptWrapper')

local MSG_AQUIRE_INPUT_FOCUS = hash('acquire_input_focus')

--- @class Scene
local Scene = class('Scene', ScriptWrapper)

function Scene:initialize(StrategiesMediator, render_order)
    self.StrategiesMediator = StrategiesMediator
    self.render_order = render_order

    self:register()
end

function Scene:init()
    gui.set_render_order(self.render_order)
    msg.post('.', MSG_AQUIRE_INPUT_FOCUS)

    self.mediator = Luject:resolve_class(self.StrategiesMediator)
end

function Scene:update(dt)
    self.mediator:update(dt)
end

function Scene:on_input(action_id, action)
    self.mediator:on_input(action_id, action)
end

function Scene:on_message(message_id, message, sender)
    self.mediator:on_message(message_id, message, sender)
end

function Scene:final()
    self.mediator:final()
end

return Scene
