local App = require('src.app')

local GUI = require('gui.gui')
local ThemeMap = GUI.ThemeMap

local Theme = class('Theme')

function Theme:initialize(context_services, nodes)
    local ui_service = context_services.ui_service

    self.theme_map = ThemeMap(ui_service, true):init({
        simple_popup = {
            is_static = true,
            map = {
                root = nodes.root,
                title = nodes.title,
                text = nodes.text,
                icon_bg = nodes.icon_bg,
                button_close = nodes.button_close_inner,
                button_next = nodes.button_next_inner,
            },
        },
    })
end

function Theme:get_map()
    return self.theme_map:get_map()
end

return Theme
