local App = require('src.app')
local class = App.libs.middleclass

local BlockView = class('BlockView')

local URLS = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props

function BlockView:initialize(block)
    block.id = factory.create(URLS.factory, block.pos, nil, nil, block.scale)
    self.obj = block
    self.sprite_url = msg.url(nil, self.obj.id, PROP.sprite)

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
    go.set_position(self.obj.pos, self.obj.id)
end

function BlockView:set_sprite()
    msg.post(self.sprite_url, PROP.play_animation, {
        id = self.obj.sprite
    })
end

function BlockView:update_scale()
    go.set_scale(self.obj.scale, self.obj.id)
end

function BlockView:delete()
    go.delete(self.obj.id)
end

return BlockView
