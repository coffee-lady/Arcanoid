local ThemeObject = require('gui.core.theme_objects.theme_object.theme_object')
local StaticThemeObject = require('gui.core.theme_objects.static_theme_object.static_theme_object')
local NodesList = require('gui.core.nodes.nodes_list.nodes_list')

local ThemeMap = class('ThemeMap')

function ThemeMap:initialize(ui_service, is_common, extra_key)
    self.ui_service = ui_service
    self.is_common = is_common
    self.scene_id = self.ui_service:get_scene_id()
    self.theme = is_common and self.ui_service:get_common_colors() or self.ui_service:get_scene_colors()
    self.extra_key = extra_key
    if extra_key then
        self.theme = self.theme[extra_key]
    end

    self.map = {}
end

-- example of scheme:
-- (nodes is a table of GUINodes)
-- {
--     widget_icon = {
--         is_static = true,
--         disable_submode = true,
--         map = {
--             title = nodes.title,
--             bg = nodes.icon,
--         },
--     },
-- }
function ThemeMap:init(scheme, scene_id)
    if scene_id then
        self.scene_id = hash(scene_id)
        self.theme = self.ui_service:get_scene_colors(self.scene_id)
        self.extra_key = self.extra_key
        if self.extra_key then
            self.theme = self.theme[self.extra_key]
        end
    end

    self.scheme = scheme

    for theme_object_key, item in pairs(scheme) do
        self:add(theme_object_key, item)
    end

    return self
end

function ThemeMap:add(theme_object_key, item)
    local ThemeObjectType = item.is_static and StaticThemeObject or ThemeObject
    local colors_key = item.colors_key and item.colors_key or theme_object_key
    self.map[theme_object_key] = ThemeObjectType(item.map, self.theme[colors_key], item.primary_mode):init(item.disable_submode)
end

function ThemeMap:add_to_list(list_key, theme_object_map, params)
    if not self.map[list_key] then
        local ThemeObjectType = params.is_static and StaticThemeObject or ThemeObject

        local map = {}
        for key, node in pairs(theme_object_map) do
            map[key] = NodesList(node)
        end

        self.map[list_key] = ThemeObjectType(map, self.theme[list_key]):init(params.disable_submode)
        return
    end

    for key, node in pairs(theme_object_map) do
        self.map[list_key]:add_to_list(key, node)
    end
end

function ThemeMap:add_list(list_key, list_data)
    local ThemeObjectType = list_data.is_static and StaticThemeObject or ThemeObject

    local map = {}

    for i = 1, #list_data.list do
        local item = list_data.list[i]

        for key, object in pairs(item) do
            if not map[key] then
                map[key] = NodesList()
            end

            map[key]:add(object)
        end
    end

    self.map[list_key] = ThemeObjectType(map, self.theme[list_key]):init(list_data.disable_submode)
end

function ThemeMap:refresh()
    self.theme = self.is_common and self.ui_service:get_common_colors() or self.ui_service:get_scene_colors(self.scene_id)

    if self.extra_key then
        self.theme = self.theme[self.extra_key]
    end

    for theme_object_key, theme_object in pairs(self.map) do
        local scheme_item = self.scheme[theme_object_key]
        local colors_key

        if scheme_item then
            colors_key = scheme_item.colors_key and scheme_item.colors_key or theme_object_key
        else
            colors_key = theme_object_key
        end

        theme_object:refresh(self.theme[colors_key])
    end
end

function ThemeMap:get_map()
    return self.map
end

return ThemeMap
