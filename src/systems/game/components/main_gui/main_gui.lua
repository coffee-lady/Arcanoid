local App = require('src.app')

local class = App.libs.middleclass

local View = require('src.systems.game.components.main_gui.view.view')

local Component = class('Component')

function Component:initialize()
    View:new()
end

return Component
