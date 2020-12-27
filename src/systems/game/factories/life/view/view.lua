local App = require('src.app')
local Components = require('src.systems.game.components.components')

local class = App.libs.middleclass
local LifeConfig = App.config.game.gui.lives
local SceneGuiURLs = App.constants.urls.gui_nodes.game_scene

local Life = Components.life

local FactoryView = class('FactoryView')

function FactoryView:initialize(nodes)
    self.nodes = nodes

    local template = gui.get_node(SceneGuiURLs.life)
    local pos = gui.get_position(template)
    local size = gui.get_size(template)

    local gui_width = gui.get_width()

    for i = 1, LifeConfig.count do
        pos.x = pos.x - size.x - gui_width * LifeConfig.indent_between
        self.nodes[#self.nodes + 1] = Life:new(pos)
    end

    gui.set_enabled(template, false)
end

return FactoryView
