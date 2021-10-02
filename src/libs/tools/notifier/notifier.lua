local class = require('src.libs.tools.middleclass.middleclass')

--- @class Notifier
local Notifier = class('Notifier')

function Notifier:initialize(message_id)
    self.subscribers = {}
    self.message_id = message_id
end

function Notifier:subscribe()
    for i = 1, #self.subscribers do
        if self.subscribers[i] == msg.url() then
            return
        end
    end

    self.subscribers[#self.subscribers + 1] = msg.url()
end

function Notifier:unsubscribe()
    for i = 1, #self.subscribers do
        if self.subscribers[i] == msg.url() then
            table.remove(self.subscribers, i)
            break
        end
    end
end

function Notifier:emit(message)
    for i = 1, #self.subscribers do
        msg.post(self.subscribers[i], self.message_id, message)
    end
end

return Notifier
