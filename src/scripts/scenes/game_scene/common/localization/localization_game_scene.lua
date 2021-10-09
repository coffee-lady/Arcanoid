local App = require('src.app')
local GUI = require('gui.gui')

local TextKeys = App.constants.localization.keys
local MSG = App.constants.msg
local Fonts = App.constants.fonts

local DateLib = App.libs.date
local LocalizationMap = GUI.LocalizationMap
local RichLocalizationMap = GUI.RichLocalizationMap
local SubscriptionsMap = App.libs.SubscriptionsMap
local SceneLocalization = GUI.SceneLocalization

local Localization = class('LocalizationMap', SceneLocalization)

Localization.__cparams = {'localization_service', 'event_bus', 'ui_service'}

function Localization:initialize(localization_service, event_bus, ui_service, nodes_map)
    SceneLocalization.initialize(self, localization_service, event_bus, ui_service, TextKeys.game_scene)

    local nodes = nodes_map:get_table()
    local button_play = nodes.button_play

    self:set_rich_map({{
        key = 'button_play',
        vars = {
            count = 5,
            level = 597,
        },
        settings = {
            initial_font = Fonts.Dosis.Bold,
            parent = button_play.text,
            text = nodes.button_play.text,
            color = self.ui_service:get_scene_colors().button_play.text,
        },
    }})
end

return Localization
