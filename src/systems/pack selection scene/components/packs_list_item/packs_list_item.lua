local App = require('src.app')

local class = App.libs.middleclass

local View = require('src.systems.pack selection scene.components.packs_list_item.view.view')
local Transform = require('src.systems.pack selection scene.components.packs_list_item.transform.transform')

local Component = class('Component')

function Component:initialize(index)
    local view = View:new(index)
    Transform:new(view.root_node, index)
end

return Component
