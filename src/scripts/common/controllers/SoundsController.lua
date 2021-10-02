local App = require('src.app')
local GUI = require('gui.gui')

local SubscriptionsMap = App.libs.SubscriptionsMap

local Sounds = App.constants.sounds
local PopupsSoundsConfig = App.config.sounds.popups

local MSG_TO_SOUND = {
    [GUI.BUTTON_DEFAULT] = Sounds.button.top,
    [GUI.BUTTON_LINK] = Sounds.button.top,
    [GUI.BUTTON_SLIDER] = Sounds.button.side,
    [GUI.BUTTON_CLOSE] = Sounds.button.close,
    [GUI.SWITCH_TOGGLED] = Sounds.button.side,
    [GUI.RADIO_BUTTON_SELECTED] = Sounds.button.side,
}

local SoundsController = class('SoundsController')

function SoundsController:initialize(context_services)
    self.sound_service = context_services.sound_service
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    --- @type EventBus
    self.event_bus = context_services.event_bus

    SubscriptionsMap(self, self.event_bus, {
        [self.scenes_service.SCREEN_TRANSITION_IN_STARTED] = self.on_scene_in,
        [self.scenes_service.SCREEN_TRANSITION_OUT_STARTED] = self.on_scene_out,
        [GUI.BUTTON_CLICKED] = self.on_button_clicked,
        [GUI.SWITCH_TOGGLED] = self.on_switch_toggled,
        [GUI.RADIO_BUTTON_SELECTED] = self.on_radio_button_selected,
    })
end

function SoundsController:on_scene_in(data)
    local screen_id = data.screen

    if not self.scenes_service:is_popup(screen_id) then
        return
    end

    if PopupsSoundsConfig[screen_id] then
        self.sound_service:play(PopupsSoundsConfig[screen_id])
    else
        self.sound_service:play(Sounds.popup.popup_in)
    end
end

function SoundsController:on_scene_out(data)
    local screen_id = data.screen

    if not self.scenes_service:is_popup(screen_id) then
        return
    end

    self.sound_service:play(Sounds.popup.popup_out)
end

function SoundsController:on_button_clicked(data)
    data = data or {}

    if not data.type_id then
        self.sound_service:play(MSG_TO_SOUND[GUI.BUTTON_DEFAULT])
    else
        self.sound_service:play(MSG_TO_SOUND[data.type_id])
    end
end

function SoundsController:on_switch_toggled()
    self.sound_service:play_force(MSG_TO_SOUND[GUI.SWITCH_TOGGLED])
end

function SoundsController:on_radio_button_selected()
    self.sound_service:play(MSG_TO_SOUND[GUI.RADIO_BUTTON_SELECTED])
end

return SoundsController
