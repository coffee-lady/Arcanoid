local App = require('src.app')
local class = App.libs.middleclass

local PacksConfig = App.config.game.packs
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene

local ListItemView = class('ListItemView')

function ListItemView:initialize(template, index)
    local data = PacksConfig.list[index]
    local nodes = gui.clone_tree(template)

    local pos_y = (index - 1) * PacksConfig.gui_item_height + PacksConfig.gui_item_height / 2
    gui.set_position(nodes[SceneGuiURLs.list_item], vmath.vector3(0, pos_y, 0))

    local template_level_title = gui.get_node(SceneGuiURLs.list_item_level_title)
    local level_text = gui.get_text(template_level_title)

    local level_title_node = nodes[SceneGuiURLs.list_item_level_title]
    gui.set_text(level_title_node, level_text .. data.first_level .. '-' .. data.last_level)

    gui.play_flipbook(nodes[SceneGuiURLs.list_item_icon], data.icon)
    gui.set_text(nodes[SceneGuiURLs.list_item_pack_title], data.title)

    local color = index % 2 == 0 and PacksConfig.even_list_item_color or PacksConfig.odd_list_item_color
    gui.set_color(nodes[SceneGuiURLs.list_item], color)
end

return ListItemView
