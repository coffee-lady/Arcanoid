local App = require('src.app')

local class = App.libs.middleclass

local Transform = require('src.systems.game.components.energy.transform.transform')
local Animations = require('src.systems.game.components.energy.animations.animations')
local Logic = require('src.systems.game.components.energy.logic.logic')
local View = require('src.systems.game.components.energy.view.view')

local EnergyComponent = class('Component')

function EnergyComponent:initialize()
    local transform = Transform:new()
    local animations = Animations:new()
    local logic = Logic:new()
    local view = View:new()

end

return EnergyComponent
