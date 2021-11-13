local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.screens.game_scene

local TextNode = GUI.TextNode
local BoxNode = GUI.BoxNode
local NodesList = GUI.NodesList

local NodesMap = class('NodesMap')

function NodesMap:initialize()
    self.nodes = {
        root = BoxNode(ID.root),
        background = BoxNode(ID.background),

        energy = {
            container = BoxNode(ID.energy_widget.container),
            icon = BoxNode(ID.energy_widget.icon),
            text = TextNode(ID.energy_widget.text),
        },

        pause = {
            container = BoxNode(ID.button_pause.container),
            icon = BoxNode(ID.button_pause.icon),
            text = TextNode(ID.button_pause.text),
        },

        lives = {
            container = BoxNode(ID.lives_widget.container),
            template = BoxNode(ID.lives_widget.template),
        },
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
