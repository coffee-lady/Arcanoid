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

function BallAnimation:init(url)
    self.url = url
    self.anim_rotation = Animation:new(url, go.animate, go.cancel_animations, rotation_anim_config)
    self.animator = Animator:new()
end

function BallAnimation:animate_rotation()
    return self.animator:play(self.anim_rotation)
end

function BallAnimation:cancel()
    self.anim_rotation:cancel()
end

return BallAnimation
