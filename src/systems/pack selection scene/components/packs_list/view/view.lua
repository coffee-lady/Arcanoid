local App = require('src.app')
local class = App.libs.middleclass

local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene

local View = class('View')

function View:initialize()
    self.node = gui.get_node(SceneGuiURLs.list)
end

return View
