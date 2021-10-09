local App = require('src.app')
local BallPhysicalView = require('src.scripts.scenes.game_scene.components.BallView.BallPhysicalView')
local class = App.libs.middleclass

local PROP = App.constants.go_props

--- @class BallView
local BallView = class('BallView')

function BallView:initialize(id, pos)
    self.id = id
    self.sprite_url = msg.url(nil, self.id, PROP.sprite)
    self.fire_sprite_url = msg.url(nil, self.id, PROP.ball.fireball)
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
    self.pos = vmath.vector3()

    self.physical_view = BallPhysicalView(id)

    msg.post(self.fire_sprite_url, PROP.disable)

    if BallData:is_fired() then
        self.view:fire_ball()
    end

    if not pos then
        self.transform:reset_pos()
    else
        self.transform:set_pos(pos)
    end

    self.transform:reset_scale()
    self.physics:reset_speed()

    self.animations.rotation.play()

    ScreenService.update_observer:subscribe(function()
        self.transform:reset_scale()
        self.transform:reset_pos()
    end)
end

function BallView:enable_fireball()
    msg.post(self.sprite_url, PROP.disable)
    msg.post(self.fire_sprite_url, PROP.enable)
end

function BallView:disable_fireball()
    msg.post(self.sprite_url, PROP.enable)
    msg.post(self.fire_sprite_url, PROP.disable)
end

function BallView:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function BallView:set_pos(pos)
    go.set_position(pos, self.id)
end

function BallView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local width = LevelService:get_data().width

    local scale_factor = (BallConfig.scale * sizes.x / width) / self.size.x

    self:set_scale(scale_factor)
end

function BallView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + BallConfig.start_rel_pos.x * sizes.x
    self.pos.y = start_coords.y + BallConfig.start_rel_pos.y * sizes.y

    self:set_pos(self.pos)
end

function BallView:animate_rotation()

end

function BallView:on_collision_response()
    self.physical_view:normalize_speed()
end

function BallView:restart()
    self:reset_pos()
    self:reset_scale()
    self.physical_view:reset_speed()
end

function BallView:accelerate(delta_speed)
    self.physical_view:accelerate(delta_speed)
end

function BallView:decelerate(delta_speed)
    local delta_speed = -vmath.vector3(delta_speed.x, delta_speed.y, delta_speed.z)
    self.physical_view:accelerate(delta_speed)
end

function BallView:on_block_destructed()
    self.physical_view:accelerate(BallConfig.delta_speed)
end

function BallView:on_pause()
    self.physical_view:stop_ball()
    -- self.animations.rotation.cancel()
end

function BallView:on_victory()
    self:delete()
end

function BallView:on_defeat()
    self.physical_view:stop_ball()
    -- self.animations.rotation.cancel()
end

function BallView:on_continue_game()
    self.physical_view:resume_moving()
end

function BallView:delete()
    self.physical_view:stop_ball()
    -- self.animations.rotation.cancel()
    self.view:delete()
end

function BallView:delete()
    self.physics:stop_ball()
    self.animations.rotation.cancel()
    go.delete(self.id)
end

return BallView
