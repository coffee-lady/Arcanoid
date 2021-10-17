local App = require('src.app')
local GO = require('go.go')

local ID = App.constants.gui.screens.game_scene

local NodesMap = class('NodesMap')

function NodesMap:initialize()
    self.nodes = {
        balls_factory = GO.Factory(ID.balls_factory),
        block_factory = GO.Factory(ID.block_factory),

        walls = {
            wall_top = GO.AnimatableNode(ID.walls.wall_top),
            wall_left = GO.AnimatableNode(ID.walls.wall_left),
            wall_right = GO.AnimatableNode(ID.walls.wall_right),
        },
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
