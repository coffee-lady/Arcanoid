local App = require('src.app')

local class = App.libs.middleclass

local Animations = require('src.systems.start scene.components.main.animations.animations')
local View = require('src.systems.start scene.components.main.view.view')

local MainComponent = class('Component')

function MainComponent:initialize()
    Animations:new()
    View:new()
end

return MainComponent
