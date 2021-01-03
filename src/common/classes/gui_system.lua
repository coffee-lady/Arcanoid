local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local LocalizationService = Services.localization
local MSG = App.constants.messages

local GUISystem = class('GUISystem')

function GUISystem:initialize(controllers, services, callbacks)
    self.SceneMsgService = services.gui_msg
    self.LocalizationService = services.localization
    self.TransitionsController = controllers.transitions

    if callbacks then
        self._init = callbacks.init
        self._on_input = callbacks.on_input
        self._on_message = callbacks.on_message
        self._final = callbacks.final
    end
end

function GUISystem:init()
    msg.post('.', MSG.common.acquire_input_focus)

    self.LocalizationService:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        self.SceneMsgService:send(nil, MSG.common.localization_change)
    end)

    self.TransitionsController:init()

    if self._init then
        self._init()
    end
end

function GUISystem:on_input(action_id, action)
    self.SceneMsgService:send(nil, action_id, action)

    if self._on_input then
        self._on_input()
    end
end

function GUISystem:on_message(message_id, message, sender)
    self.SceneMsgService:send(message.receiver, message_id, message.data)

    self.TransitionsController:on_message(message_id, message, sender)

    if self._on_message then
        self._on_message()
    end
end

function GUISystem:final()
    self.local_subs:unsubscribe()

    self.SceneMsgService:reset()

    self.TransitionsController:final()
    self.LocalizationService:final()

    if self._final then
        self._final()
    end
end

return GUISystem
