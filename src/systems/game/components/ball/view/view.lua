local App = require('src.app')
local class = App.libs.middleclass

local PROP = App.constants.go_props

local View = class('View')

function View:initialize(id)
    self.id = id
    self.sprite_url = msg.url(nil, self.id, PROP.sprite)
    self.fire_sprite_url = msg.url(nil, self.id, PROP.ball.fireball)

    msg.post(self.fire_sprite_url, PROP.disable)
end

function View:fire_ball()
    msg.post(self.sprite_url, PROP.disable)
    msg.post(self.fire_sprite_url, PROP.enable)
end

function View:put_out_ball()
    msg.post(self.sprite_url, PROP.enable)
    msg.post(self.fire_sprite_url, PROP.disable)
end

function View:delete()
    go.delete(self.id)
end

return View
