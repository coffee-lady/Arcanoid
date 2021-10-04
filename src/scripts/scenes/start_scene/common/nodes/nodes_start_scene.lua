local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.screens.start_scene

local TextNode = GUI.TextNode
local BoxNode = GUI.BoxNode
local NodesList = GUI.NodesList

local NodesMap = class('NodesMap')

function NodesMap:initialize()
    self.nodes = {
        root = BoxNode(ID.root),

        button_play = {
            inner = BoxNode(ID.button_play.inner),
            text = TextNode(ID.button_play.text),
        },
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
