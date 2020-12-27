local App = require('src.app')

local class = App.libs.middleclass

local Transform = require('src.systems.game.components.life.transform.transform')
local Animations = require('src.systems.game.components.life.animations.animations')
local View = require('src.systems.game.components.life.view.view')

local LifeComponent = class('Component')

function LifeComponent:initialize(pos)
    self.view = View:new()
    self.transform = Transform:new(self.view.node, pos)
    self.animations = Animations:new()

    self.transform:set_pos(pos)
end

function LifeComponent:activate()
    self.view:show()
end

function LifeComponent:deactivate()
    self.view:hide()
end

return LifeComponent
