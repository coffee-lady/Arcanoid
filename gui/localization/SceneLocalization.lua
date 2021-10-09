local LocalizationMap = require('gui.localization.localization_map')
local RichTextNode = require('gui.extensions.rich_text_node.rich_text_node')
local RichLocalizationMap = require('gui.extensions.rich_localization.rich_localization_map')
local SubscriptionsMap = require('src.libs.event_bus.subscriptions_map')

local SceneLocalization = class('SceneLocalization')

SceneLocalization.__cparams = {'localization_service', 'event_bus_gui', 'ui_service'}

function SceneLocalization:initialize(localization_service, event_bus, ui_service, text_key)
    --- @type LocalizationService
    self.localization_service = localization_service
    --- @type EventBus
    self.event_bus = event_bus
    --- @type UIService
    self.ui_service = ui_service

    self.text_key = text_key

    self:_set_subscriptions()
end

function SceneLocalization:set_map(map)
    self.map = LocalizationMap(self.localization_service, self.text_key, map)
end

function SceneLocalization:set_rich_map(map)
    for _, item in pairs(map) do
        local item_settings = item.settings
        item_settings.width = item_settings.width or item_settings.parent:get_width()
        item_settings.align = item_settings.align or RichTextNode.ALIGN_CENTER
        item_settings.valign = item_settings.valign or RichTextNode.VALIGN_MIDDLE

        if item_settings.combine_words == nil then
            item_settings.combine_words = true
        end
    end

    self.rich_map = RichLocalizationMap(self.localization_service, self.text_key, map)
end

function SceneLocalization:_set_subscriptions()
    self.subs = SubscriptionsMap(self, self.event_bus, {
        [self.localization_service.MSG_LANG_CHANGED] = self.on_language_changed,
    })
end

function SceneLocalization:on_language_changed()
    if self.map then
        self.map:refresh()
    end
    if self.rich_map then
        self.rich_map:refresh()
    end
end

function SceneLocalization:final()
    self.subs:unsubscribe()
end

return SceneLocalization
