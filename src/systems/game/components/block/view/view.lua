local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local View = class('View')

function View:initialize(id, data)
    self.id = id
    self.data = data
    self.sprite_url = msg.url(nil, self.id, PROP.sprite)
    self.cracks_url = msg.url(nil, self.id, PROP.block.cracks)
    self.sprite = data.sprite

    msg.post(self.cracks_url, PROP.disable)

    self:set_sprite()
end

function View:set_sprite()
    msg.post(self.sprite_url, PROP.play_animation, {
        id = hash(self.data.sprite)
    })
end

function View:delete()
    go.delete(self.id)
end

return View
