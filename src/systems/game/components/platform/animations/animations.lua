local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local PROP = App.constants.go_props
local PlatformConfig = App.config.game.go.platform

local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local ScreenService = Services.screen

local pos_x_anim_config = {
    property = PROP.position_x,
    duration = PlatformConfig.moving_duration.start,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_ONCE_FORWARD
}

local scale_anim_config = {
    property = PROP.scale,
    duration = PlatformConfig.scaling_duration,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_ONCE_FORWARD
}

local animator = Animator:new()

local Animations = class('Animations')

function Animations:initialize(id)
    self.id = id
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
end

function Animations:animate_extension(percentage)
    local sizes = ScreenService:get_sizes()
    local scale = go.get_scale(self.id).z

    scale = scale + percentage * sizes.x / self.size.x

    local min = PlatformConfig.scale.min * sizes.x / self.size.x
    local max = PlatformConfig.scale.max * sizes.x / self.size.x

    if scale < min or scale > max then
        return
    end

    scale_anim_config.to = scale

    local anim_scale = Animation:new(self.id, go.animate, go.cancel_animations, scale_anim_config)

    animator:play(anim_scale):finish()
end

function Animations:accelerate_moving(delta_time)
    local duration = pos_x_anim_config.duration - delta_time
    local min = PlatformConfig.moving_duration.min
    local max = PlatformConfig.moving_duration.max

    if duration > min and duration < max then
        pos_x_anim_config.duration = duration
    end
end

function Animations:animate_pos_x(x)
    local scale = go.get_scale(self.id).z

    local start_coords, end_coords = ScreenService:get_coords()
    local min_x = start_coords.x + self.size.x * scale / 2
    local max_x = end_coords.x - self.size.x * scale / 2

    if x < min_x then
        x = min_x
    elseif x > max_x then
        x = max_x
    end

    pos_x_anim_config.to = x

    local anim_pos_x = Animation:new(self.id, go.animate, go.cancel_animations, pos_x_anim_config)

    return animator:play(anim_pos_x):finish()
end

return Animations
