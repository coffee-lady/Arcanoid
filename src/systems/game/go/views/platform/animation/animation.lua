local App = require('src.app')

local Config = App.config
local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local PlatformConfig = Config.game.go.platform
local animator = Animator:new()

local PROP = App.constants.go_props

local rotation_anim_config = {
    property = PROP.position_x,
    duration = PlatformConfig.moving_duration,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_ONCE_FORWARD
}

local scale_anim_config = {
    property = PROP.scale,
    duration = PlatformConfig.scaling_duration,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_ONCE_FORWARD
}

local PlatformAnimation = {}

function PlatformAnimation:init(url)
    self.url = url
end

function PlatformAnimation:animate_pos_x(new_pos, duration)
    rotation_anim_config.to = new_pos.x
    rotation_anim_config.duration = duration

    local anim_pos_x = Animation:new(self.url, go.animate, go.cancel_animations, rotation_anim_config)

    return animator:play(anim_pos_x):finish()
end

function PlatformAnimation:animate_scale(scale)
    scale_anim_config.to = scale
    local anim_scale = Animation:new(self.url, go.animate, go.cancel_animations, scale_anim_config)

    return animator:play(anim_scale):finish()
end

return PlatformAnimation
