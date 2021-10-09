local App = require('src.app')
local GUI = require('gui.gui')

local ThemeMap = GUI.ThemeMap
local NodesList = GUI.NodesList
local SubscriptionsMap = App.libs.SubscriptionsMap

local MSG = App.constants.msg

local Theme = class('ThemeMap', ThemeMap)

Theme.__cparams = {'event_bus_gui', 'ui_service'}

function Theme:initialize(event_bus, ui_service, nodes_map)
    local nodes = nodes_map:get_table()

    local settings = {}
    local scheme = {
        root = {
            is_static = true,
            map = {
                bg = nodes.background,
            },
        },
    }

    ThemeMap.initialize(self, event_bus, ui_service, settings, scheme)
end

return Theme
