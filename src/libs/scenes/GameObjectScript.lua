local Luject = require('src.libs.luject.luject')
local ScriptWrapper = require('src.libs.script_wrapper.ScriptWrapper')

--- @class GameObjectScript
local GameObjectScript = class('GameObjectScript', ScriptWrapper)

GameObjectScript.__cparams = {'event_bus_go'}

function GameObjectScript:initialize(event_bus_go)
    --- @type EventBus
    self.event_bus_go = event_bus_go

    self:register()
end

function GameObjectScript:init(id)
    self.id = id
end

function GameObjectScript:on_message(message_id, message, sender)
    message.go_id = self.id
    self.event_bus_go:emit(message_id, message)
end

return GameObjectScript
