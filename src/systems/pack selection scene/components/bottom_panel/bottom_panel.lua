local App = require('src.app')

local class = App.libs.middleclass

local View = require('src.systems.pack selection scene.components.bottom_panel.view.view')

local BottomPanelComponent = class('Component')

function BottomPanelComponent:initialize()
    View:new()
end

return BottomPanelComponent
