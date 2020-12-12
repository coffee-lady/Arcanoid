local App = require('src.app')
local class = App.libs.middleclass

local BlockView = class('BlockView')

local FACTORY = '/game_scene#factory'

function BlockView:initialize(block)
    block.id = factory.create(msg.url(FACTORY), block.pos, nil, nil, block.scale)
    self.block = block

    block.update_observer:subscribe(function()
        self:rebuild()
    end)

    self:set_sprite()
    self:rebuild()
end

function BlockView:rebuild()
    self:update_pos()
    self:update_scale()
end

function BlockView:update_pos()
    go.set_position(self.block.pos, self.block.id)
end

function BlockView:set_sprite()
    msg.post(msg.url(nil, self.block.id, 'sprite'), 'play_animation', {
        id = self.block.sprite
    })
end

function BlockView:update_scale()
    go.set_scale(self.block.scale, self.block.id)
end

return BlockView
