local App = require('src.app')
local class = App.libs.middleclass

local URL = App.constants.urls
local SceneGuiURLs = URL.gui_nodes.game_victory_scene

local LevelView = class('PackView')

function LevelView:initialize(prev_level, next_level)
    local level_title_node = gui.get_node(SceneGuiURLs.text.level_title)
    local level_text = gui.get_text(level_title_node)

    gui.set_text(level_title_node, level_text .. next_level)
end

return LevelView
