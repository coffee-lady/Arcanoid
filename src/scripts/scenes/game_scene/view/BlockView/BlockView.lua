local App = require('src.app')
local BlockPhysicalView = require('src.scripts.scenes.game_scene.components.BlockView.BlockPhysicalView')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local BlockView = class('BlockView')

function BlockView:initialize(id, data)
    self.id = id
    self.data = data
    self.sprite_url = msg.url(nil, self.id, PROP.sprite)
    self.cracks_url = msg.url(nil, self.id, PROP.block.cracks)
    self.sprite_url = msg.url(nil, id, PROP.sprite)
    self.cracks_url = msg.url(nil, id, PROP.block.cracks)

    local pfx_prop = data.destroyable and PROP.block.snowglobe_breaking or PROP.block.chimney_breaking
    self.pfx = msg.url(nil, id, pfx_prop)

    self.swnowglobe_top = msg.url(nil, id, PROP.block.snowglobe_top)
    self.snowglobe_bottom = msg.url(nil, id, PROP.block.snowglobe_bottom)
    self.sprite = data.sprite

    self.physical_view = BlockPhysicalView(id)

    msg.post(self.cracks_url, PROP.disable)

    self:set_sprite()
end

function BlockView:animate_cracks()
    msg.post(self.cracks_url, PROP.enable)
end

function BlockView:animate_breaking()
    particlefx.play(self.pfx)

    msg.post(self.swnowglobe_top, PROP.disable)
    msg.post(self.snowglobe_bottom, PROP.disable)
    msg.post(self.cracks_url, PROP.disable)
end

function BlockView:set_sprite()
    msg.post(self.sprite_url, PROP.play_animation, {
        id = hash(self.data.sprite),
    })
end

function BlockView:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function BlockView:set_pos(pos)
    go.set_position(pos, self.id)
end

function BlockView:delete()
    go.delete(self.id)
end

return BlockView
