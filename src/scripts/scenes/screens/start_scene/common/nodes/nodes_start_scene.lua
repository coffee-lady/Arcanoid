local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.screens.start_scene
local ButtonsID = ID.buttons

local TextNode = GUI.TextNode
local BoxNode = GUI.BoxNode
local NodesList = GUI.NodesList

local NodesMap = {}

function NodesMap:init()
    self.nodes = {
        root = BoxNode(ID.root),

        button_play = {
            inner = BoxNode(ButtonsID.button_play.inner),
            text = TextNode(ButtonsID.button_play.text),
        },
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
