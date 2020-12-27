local App = require('src.app')

local class = App.libs.middleclass
local SceneURLs = App.constants.urls.gui_nodes.game_scene

local View = class('View')

function View:initialize()
    local template = gui.get_node(SceneURLs.life)

    self.node = gui.clone(template)
end

function View:show()
    gui.set_enabled(self.node, true)
end

function View:hide()
    gui.set_enabled(self.node, false)
end

return View
