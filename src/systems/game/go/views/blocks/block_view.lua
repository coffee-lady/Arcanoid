local App = require('src.app')
local Animation = require('src.systems.game.go.views.blocks.animation')
local class = App.libs.middleclass

local GAME_URLS = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props

local BlockView = class('BlockView')

function BlockView:initialize(block)
    self.data = block
end

function BlockView:create_go()
    self.id = factory.create(GAME_URLS.factory, self.pos, nil, nil, self.scale)
    self.sprite_url = msg.url(nil, self.id, PROP.sprite)
    self.cracks_url = msg.url(nil, self.id, PROP.block.cracks)
    self.pfx_url = msg.url(nil, self.id, PROP.block.snowglobe_breaking)
    self:set_sprite()

    msg.post(self.cracks_url, 'disable')
end

function BlockView:set_sprite()
    msg.post(self.sprite_url, PROP.play_animation, {
        id = self.data.sprite
    })
end

function BlockView:on_lives_decreasing(lives)
    if lives == 1 then
        Animation:animate_cracks(self.cracks_url)
    end

    if lives == 0 then
        Animation:animate_breaking(self.pfx_url)
    end
end

function BlockView:rebuild()
    self:update_pos()
    self:update_scale()
end

function BlockView:update_pos()
    go.set_position(self.pos, self.id)
end

function BlockView:update_scale()
    go.set_scale(self.scale, self.id)
end

function BlockView:delete()
    Animation:animate_sprite(self.id, self.cracks_url):exec(function()
        go.delete(self.id)
    end)
end

return BlockView
