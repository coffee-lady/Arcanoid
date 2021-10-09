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
            container = BoxNode(ID.energy.container),
            icon = BoxNode(ID.energy.icon),
            text = TextNode(ID.energy.text),
        },

        pause = {
            container = BoxNode(ID.pause.container),
            icon = BoxNode(ID.pause.icon),
            text = TextNode(ID.pause.text),
        },

        lives = {
            container = BoxNode(ID.lives.container),
            template = BoxNode(ID.lives.template),
        },
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
