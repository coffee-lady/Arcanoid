local App = require('src.app')
local GO = require('go.go')

local ID = App.constants.gui.screens.game_scene

local NodesMap = class('NodesMap')

function NodesMap:initialize()
    self.nodes = {
        balls_factory = GO.Factory(ID.balls_factory),
        block_factory = GO.Factory(ID.block_factory),
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
