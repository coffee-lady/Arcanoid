local App = require('src.app')
local GO = require('go.go')

local Factory = GO.Factory
local AnimatableNode = GO.AnimatableNode

local ID = App.constants.gui.screens.game_scene

local NodesMap = class('NodesMap')

function NodesMap:initialize()
    self.nodes = {
        balls_factory = Factory(ID.balls_factory),
        blocks_factory = Factory(ID.blocks_factory),

        walls = {
            wall_top = AnimatableNode(ID.walls.wall_top),
            wall_left = AnimatableNode(ID.walls.wall_left),
            wall_right = AnimatableNode(ID.walls.wall_right),
        },

        losing_zone = AnimatableNode(ID.losing_zone),
        platform = AnimatableNode(ID.platform),
    }
end

function NodesMap:get_table()
    return self.nodes
end

return NodesMap
