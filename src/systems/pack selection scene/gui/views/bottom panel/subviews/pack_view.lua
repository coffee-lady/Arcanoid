local App = require('src.app')
local class = App.libs.middleclass

local URL = App.constants.urls
local SceneGuiURLs = URL.gui_nodes.pack_selection_scene

local BottomPanelPackView = class('BottomPanelPackView')

function BottomPanelPackView:initialize(pack)
    local pack_title_node = gui.get_node(SceneGuiURLs.text.pack_title)
    local pack_text = gui.get_text(pack_title_node)
    local pack_icon_node = gui.get_node(SceneGuiURLs.pack_icon)

    gui.play_flipbook(pack_icon_node, pack.icon)
    gui.set_text(pack_title_node, pack_text .. pack.title)
end

return BottomPanelPackView
