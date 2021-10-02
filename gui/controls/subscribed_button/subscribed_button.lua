local Libs = require('src.libs.libs')
local Button = require('gui.controls.button.button')

local class = Libs.middleclass

local ACTION_CLICK = hash('click')

--- @class SubscribedButton : Button
local SubscribedButton = class('SubscribedButton', Button)

function SubscribedButton:initialize(ids, context_services, on_click)
    Button.initialize(self, ids, context_services, on_click)

    --- @type EventBus
    self.event_bus = context_services.event_bus

    self.subs = self.event_bus:on(ACTION_CLICK, self.click, self)
end

function SubscribedButton:get_subscription()
    return self.subs
end

function SubscribedButton:delete()
    self.subs:unsubscribe()
end

return SubscribedButton
