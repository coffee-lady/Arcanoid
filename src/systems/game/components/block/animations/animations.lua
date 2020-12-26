local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local Animations = class('Animations')

function Animations:initialize(id)
    self.sprite_url = msg.url(nil, id, PROP.sprite)
    self.cracks_url = msg.url(nil, id, PROP.block.cracks)
    self.pfx_url = msg.url(nil, id, PROP.block.snowglobe_breaking)

    self.swnowglobe_top = msg.url(nil, id, PROP.block.snowglobe_top)
    self.snowglobe_bottom = msg.url(nil, id, PROP.block.snowglobe_bottom)
end

function Animations:animate_cracks()
    msg.post(self.cracks_url, PROP.enable)
end

function Animations:animate_breaking()
    particlefx.play(self.pfx_url)

    msg.post(self.swnowglobe_top, PROP.disable)
    msg.post(self.snowglobe_bottom, PROP.disable)
    msg.post(self.cracks_url, PROP.disable)
end

return Animations
