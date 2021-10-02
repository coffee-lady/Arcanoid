local Libs = require('src.libs.libs')
local Link = require('gui.controls.link.link')

local class = Libs.middleclass

local ACTION_CLICK = hash('click')

--- @class SubscribedLink : Link
local SubscribedLink = class('SubscribedLink', Link)

function SubscribedLink:initialize(ids, context_services, on_click)
    Link.initialize(self, ids, context_services, on_click)

    --- @type EventBus
    self.event_bus = context_services.event_bus

    self.subs = self.event_bus:on(ACTION_CLICK, self.click, self)
end

function SubscribedLink:get_subscription()
    return self.subs
end

function SubscribedLink:delete()
    self.subs:unsubscribe()
end

return SubscribedLink
