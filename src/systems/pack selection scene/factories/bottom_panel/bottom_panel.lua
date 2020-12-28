local Components = require('src.systems.pack selection scene.components.components')

local BottomPanel = Components.bottom_panel

local Factory = {}

function Factory:init()
    BottomPanel:new()
end

return Factory
