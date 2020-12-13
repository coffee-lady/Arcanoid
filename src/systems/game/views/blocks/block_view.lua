local App = require('src.app')
local class = App.libs.middleclass

local BlockView = class('BlockView')

local URLS = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props

function BlockView:initialize(block)
    block.id = factory.create(URLS.factory, block.pos, nil, nil, block.scale)
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
    msg.post(msg.url(nil, self.block.id, PROP.sprite), PROP.play_animation, {
        id = self.block.sprite
    })
end

function BlockView:update_scale()
    go.set_scale(self.block.scale, self.block.id)
end

function BlockView:delete()
    go.delete(self.block.id)
end

return BlockView
