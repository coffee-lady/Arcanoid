local App = require('src.app')

local Config = App.config
local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local BallConfig = Config.game.go.ball

local PROP = App.constants.go_props

local rotation_anim_config = {
    property = PROP.euler_z,
    to = BallConfig.rotation_angle,
    duration = BallConfig.rotation_duration,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_LOOP_FORWARD
}

local BallAnimation = {}

function BallAnimation:animate_rotation(url)
    local anim_rotation = Animation:new(url, go.animate, go.cancel, rotation_anim_config)

    return Animator:new():play(anim_rotation)
end

return BallAnimation
