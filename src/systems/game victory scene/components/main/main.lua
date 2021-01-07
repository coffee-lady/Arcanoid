local App = require('src.app')

local class = App.libs.middleclass

local Animations = require('src.systems.game victory scene.components.main.animations.animations')
local View = require('src.systems.game victory scene.components.main.view.view')

local MainComponent = class('Component')

function MainComponent:initialize()
    View:new()
    local animations = Animations:new()

    animations:play()
end

return MainComponent
