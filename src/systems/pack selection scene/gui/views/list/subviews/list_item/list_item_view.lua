local App = require('src.app')
local class = App.libs.middleclass
local PackSubview = require('src.systems.pack selection scene.gui.views.list.subviews.list_item.pack_view')
local LevelSubview = require('src.systems.pack selection scene.gui.views.list.subviews.list_item.level_view')

local PacksConfig = App.config.game.packs
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene

local ListItemView = class('ListItemView')

local function set_pos(nodes, index)
    local pos_y = (index - 1) * PacksConfig.gui_item_height + PacksConfig.gui_item_height / 2
    gui.set_position(nodes[SceneGuiURLs.list_item], vmath.vector3(0, pos_y, 0))
end

local function set_bg_color(nodes, index)
    local color = index % 2 == 0 and PacksConfig.even_list_item_color or PacksConfig.odd_list_item_color
    gui.set_color(nodes[SceneGuiURLs.list_item], color)
end

function ListItemView:initialize(template, index)
    local pack_data = PacksConfig.list[index]
    local nodes = gui.clone_tree(template)

    set_pos(nodes, index)
    set_bg_color(nodes, index)

    self.pack_view = PackSubview:new(nodes, pack_data)
    self.pack_view = LevelSubview:new(nodes, pack_data)
end

return ListItemView
