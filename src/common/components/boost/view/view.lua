local App = require('src.app')
local class = App.libs.middleclass

local PROP = App.constants.go_props

local View = class('View')

function View:initialize(id, config)
    self.id = id

    if config.icon then
        msg.post(msg.url(nil, self.id, PROP.sprite), PROP.play_animation, {
            id = hash(config.icon)
        })
    end
end

function View:destroy()
    go.delete(self.id)
end

return View
