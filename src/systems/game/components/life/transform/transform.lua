local App = require('src.app')
local class = App.libs.middleclass

local Transform = class('Transform')

function Transform:initialize(node)
    self.node = node
end

function Transform:set_pos(pos)
    gui.set_position(self.node, pos)
end

return Transform
