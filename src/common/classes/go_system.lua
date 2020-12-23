local App = require('src.app')
local Services = require('src.services.services')

local ScreenService = Services.screen

local class = App.libs.middleclass
local MSG = App.constants.messages

local CLASS_NAME = 'GOSYSTEM'
local GOSystem = class(CLASS_NAME)

function GOSystem:initialize(msg_service, callbacks)
    self.SceneMsgService = msg_service

    if callbacks then
        self._init = callbacks.init
        self._on_input = callbacks.on_input
        self._on_message = callbacks.on_message
        self._final = callbacks.final
    end
end

function GOSystem:on(map)
    self.map = map
end

function GOSystem:init()
    msg.post('.', MSG.common.acquire_input_focus)

    ScreenService:add_listener()

    for message, callback in pairs(self.map) do
        self.SceneMsgService:on(CLASS_NAME, message, callback)
    end

    if self._init then
        self._init()
    end
end

function GOSystem:on_input(action_id, action)
    self.SceneMsgService:send(nil, action_id, action)

    if self._on_input then
        self._on_input(action_id, action)
    end
end

function GOSystem:on_message(message_id, message)
    ScreenService:on_message(message_id)

    self.SceneMsgService:send(message.receiver, message_id, message.data)

    if self._on_message then
        self._on_message(message_id, message)
    end
end

function GOSystem:final()
    ScreenService:remove_listener()

    self.SceneMsgService:reset()

    if self._final then
        self._final()
    end
end

return GOSystem
