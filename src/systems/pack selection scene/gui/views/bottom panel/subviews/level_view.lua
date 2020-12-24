local App = require('src.app')
local class = App.libs.middleclass

local URL = App.constants.urls
local SceneGuiURLs = URL.gui_nodes.pack_selection_scene

local BottomPanelLevelView = class('BottomPanelLevelView')

function BottomPanelLevelView:initialize(level)
    local level_title_node = gui.get_node(SceneGuiURLs.text.level_title)
    local level_text = gui.get_text(level_title_node)

    gui.set_text(level_title_node, level_text .. level)
end

return BottomPanelLevelView
