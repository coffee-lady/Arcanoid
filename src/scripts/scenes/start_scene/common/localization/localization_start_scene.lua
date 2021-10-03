local App = require('src.app')
local GUI = require('gui.gui')
local Nodes = require('src.scripts.scenes.start_scene.common.nodes.nodes_start_scene')

local TextKeys = App.constants.localization.keys
local MSG = App.constants.msg

local DateLib = App.libs.date
local LocalizationMap = GUI.LocalizationMap
local SubscriptionsMap = App.libs.SubscriptionsMap

local LocalizationMap = class('LocalizationMap')

LocalizationMap.__cparams = {'localization_service', 'event_bus'}

function LocalizationMap:initialize(localization_service, event_bus)
    self.localization_service = localization_service
    --- @type EventBus
    self.event_bus = event_bus

    local nodes = Nodes:get_table()

    self.map = LocalizationMap(localization_service, TextKeys.start_scene, {})

    self:_set_subscriptions()
end

function LocalizationMap:add(data)
    self.map:add(data)
end

function LocalizationMap:_set_subscriptions()
    SubscriptionsMap(self, self.event_bus, {
        [MSG.localization.language_changed] = self.on_language_changed,
    })
end

function LocalizationMap:on_language_changed()
    self.map:refresh()
end

return LocalizationMap
