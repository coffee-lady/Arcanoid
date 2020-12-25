local App = require('src.app')
local class = App.libs.middleclass

local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene

local ListItemLevelView = class('ListItemLevelView')

function ListItemLevelView:initialize(nodes, data)
    local template_level_title = gui.get_node(SceneGuiURLs.list_item_level_title)
    local level_text = gui.get_text(template_level_title)

    local level_title_node = nodes[SceneGuiURLs.list_item_level_title]
    gui.set_text(level_title_node, level_text .. data.first_level .. '-' .. data.last_level)
end

return ListItemLevelView
