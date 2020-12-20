local App = require('src.app')
local class = App.libs.middleclass

local Config = App.config

local LivesConfig = Config.game.player.lives
local GUILivesConfig = Config.game.gui.lives

local NODE_SIZE = vmath.vector3(GUILivesConfig.size.x, GUILivesConfig.size.y, 0)
local ANIM = GUILivesConfig.animation

local LivesView = class('LivesView')

function LivesView:initialize()
    self.nodes = {}

    self:init_lives(LivesConfig.count)
end

function LivesView:init_lives(max_lives)
    local pos = vmath.vector3(0, 0, 0)
    local gui_sizes = {
        x = gui.get_width(),
        y = gui.get_height()
    }

    pos.x = gui_sizes.x * GUILivesConfig.rel_pos.x
    pos.y = gui_sizes.y * GUILivesConfig.rel_pos.y

    for i = 1, max_lives do
        local node = self:create_node(pos)
        self.nodes[i] = node
        pos.x = pos.x - gui.get_size(node).x - GUILivesConfig.rel_pos_between.x * gui_sizes.x
    end
end

function LivesView:create_node(pos)
    local node = gui.new_box_node(pos, NODE_SIZE)

    gui.set_texture(node, GUILivesConfig.texture)
    gui.play_flipbook(node, ANIM)

    gui.set_xanchor(node, gui.ANCHOR_RIGHT)
    gui.set_yanchor(node, gui.ANCHOR_TOP)

    return node
end

function LivesView:show(index)
    gui.set_enabled(self.nodes[index], true)
end

function LivesView:hide(index)
    gui.set_enabled(self.nodes[index], false)
end

return LivesView
