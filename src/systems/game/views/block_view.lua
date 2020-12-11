local App = require('src.app')
local class = App.libs.middleclass

local BlockView = class('BlockView')

local FACTORY = '/game_scene#factory'

function BlockView:initialize(block)
    block.id = factory.create(msg.url(FACTORY), block.pos, nil, nil, block.scale)
    self.block = block

    local color = block.color
    self:set_color(vmath.vector4(color[1], color[2], color[3], color[4]))

    block.observer:subscribe(function ()
        self:rebuild()
    end)
end

function BlockView:rebuild()
    go.set_position(self.block.pos, self.block.id)
    go.set_scale(self.block.scale, self.block.id)
end

function BlockView:set_color(color)
    self.color = color
    go.set(msg.url(nil, self.block.id, 'sprite'), 'tint', color)
end

return BlockView
