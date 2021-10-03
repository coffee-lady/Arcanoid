local AnimatedThemeGUINode = require('gui.core.theme_objects.animated_theme_object.animated_theme_object')

--- @class ThemeGUINode : AnimatedThemeObject
local ThemeGUINode = class('ThemeGUINode', AnimatedThemeGUINode)

function ThemeGUINode:init(disable_submode)
    self.disable_submode = disable_submode

    self:_paint_with_current_colors()

    return self
end

function ThemeGUINode:switch_to(mode, submode)
    assert(mode, 'theme_object mode is not registered')

    self.current_mode = mode

    self.colors = self.theme[mode]
    assert(self.colors, 'theme_object incorrect mode')

    if submode then
        self.current_submode = submode
    end

    self:_paint_with_current_colors()
end

function ThemeGUINode:switch_to_primary(mode)
    self:switch_to(self.PRIMARY_MODE, mode)
end

function ThemeGUINode:switch_to_error(mode)
    self:switch_to(self.ERROR_MODE, mode)
end

function ThemeGUINode:select()
    self.current_submode = self.SUBMODE.selection

    self:_paint_with_current_colors()
end

function ThemeGUINode:deselect()
    self.current_submode = self.SUBMODE.base

    self:_paint_with_current_colors()
end

function ThemeGUINode:highlight(highlight_mode)
    self.current_submode = self.SUBMODE.highlight
    self.current_highlight = highlight_mode

    local mode_colors = self.colors.highlight[highlight_mode]

    self:_paint(mode_colors)
end

function ThemeGUINode:refresh(theme)
    self.theme = theme
    self.colors = self.theme[self.current_mode]
    self:_paint_with_current_colors()
end

function ThemeGUINode:add_to_list(key, node)
    self.nodes[key]:add(node)

    return self
end

function ThemeGUINode:_paint_with_current_colors()
    local mode_colors = self.colors

    if not self.disable_submode then
        mode_colors = mode_colors[self.current_submode]
    end

    if not self.disable_submode and self.current_submode == self.SUBMODE.highlight then
        mode_colors = mode_colors[self.current_highlight]
    end

    self:_paint(mode_colors)
end

function ThemeGUINode:_paint(mode_colors)
    for key, node in pairs(self.nodes) do
        if mode_colors[key] then
            node:set_color(mode_colors[key])
        end
    end
end

return ThemeGUINode
