local App = require('src.app')
local GUI = require('gui.gui')
local View = require('src.scripts.common.components.UserDataComponent.view.UserDataView')

local MSG = App.constants.msg

local SubscriptionsMap = App.libs.SubscriptionsMap

--- @class UserDataComponent : Widget
local UserDataComponent = class('UserDataComponent', GUI.Widget)

function UserDataComponent:initialize(context_services, nodes, ui_config, view_settings)
    GUI.Widget.initialize(self, context_services)

    self.auth_service = context_services.auth_service
    --- @type EventBus
    self.event_bus = context_services.event_bus
    self.view = View(context_services, nodes, ui_config, view_settings)

    self:set_subscriptions()
    self:update_view()
end

function UserDataComponent:set_subscriptions()
    self.subs = SubscriptionsMap(self, self.event_bus, {
        [MSG.auth.success_auth] = self.on_user_authorized,
    })

    self.event_bus:on(MSG.localization.language_changed, self.on_localization_changed, self)
end

function UserDataComponent:on_localization_changed()
    self:update_view()
end

function UserDataComponent:on_user_authorized()
    self:update_view()
end

function UserDataComponent:update_view()
    self.view:update()
end

function UserDataComponent:final()
    self.subs:unsubscribe()
end

return UserDataComponent
