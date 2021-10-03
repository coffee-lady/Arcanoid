local AnimatedThemeObject = require('gui.core.theme_objects.animated_theme_object.animated_theme_object')

--- @class StaticThemeObject : AnimatedThemeObject
local StaticThemeObject = class('StaticThemeObject', AnimatedThemeObject)

--- @param elems table <string, Node | NodesList >
function StaticThemeObject:initialize(elems, theme)
    self.nodes = elems
    self.colors = theme
end

function StaticThemeObject:init()
    self:_paint(self.colors)

    return self
end

function StaticThemeObject:add_to_list(key, node)
    self.nodes[key]:add(node)

    return self
end

function StaticThemeObject:refresh(theme)
    self.colors = theme
    self:_paint(self.colors)
end

function StaticThemeObject:_paint(mode_colors)
    for key, node in pairs(self.nodes) do
        if mode_colors[key] then
            node:set_color(mode_colors[key])
        end
    end
end

return StaticThemeObject
