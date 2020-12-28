local App = require('src.app')

local class = App.libs.middleclass

local PacksConfig = App.config.game.packs

local Transform = class('Transform')

function Transform:initialize(root_node, index)
    local pos_y = (index - 1) * PacksConfig.gui_item_height + PacksConfig.gui_item_height / 2

    gui.set_position(root_node, vmath.vector3(0, pos_y, 0))
end

return Transform
