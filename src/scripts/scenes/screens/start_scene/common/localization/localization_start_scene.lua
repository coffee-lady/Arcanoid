local App = require('src.app')
local GUI = require('gui.gui')
local Nodes = require('src.scripts.scenes.screens.start_scene.common.nodes.nodes_start_scene')

local TextKeys = App.constants.localization.keys
local MSG = App.constants.msg

local DateLib = App.libs.date
local LocalizationMap = GUI.LocalizationMap
local SubscriptionsMap = App.libs.SubscriptionsMap

local Localization = {}

function Localization:init(context_services)
    self.progress_service = context_services.progress_service
    self.localization = context_services.localization
    --- @type EventBus
    self.event_bus = context_services.event_bus

    local nodes = Nodes:get_table()

    self.map = LocalizationMap(context_services, TextKeys.start_scene, {})

    self:_set_subscriptions()
end

function Localization:add(data)
    self.map:add(data)
end

function Localization:_set_subscriptions()
    SubscriptionsMap(self, self.event_bus, {
        [MSG.localization.language_changed] = self.on_language_changed,
    })
end

function Localization:on_language_changed()
    self.map:refresh()
end

return Localization
