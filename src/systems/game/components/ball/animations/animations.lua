local App = require('src.app')

local class = App.libs.middleclass
local BallConfig = App.config.game.go.ball
local PROP = App.constants.go_props
local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local Animations = class('Animations')

local animator = Animator:new()

local rotation_config = {
    property = PROP.euler_z,
    to = BallConfig.rotation_angle,
    duration = BallConfig.rotation_duration,
    easing = go.EASING_LINEAR,
    playback = go.PLAYBACK_LOOP_FORWARD
}

function Animations:initialize(id)
    local anim_rotation = Animation:new(id, go.animate, go.cancel_animations, rotation_config)

    self.rotation = {
        play = function()
            animator:play(anim_rotation):finish()
        end,
        cancel = function()
            anim_rotation:cancel()
        end
    }
end

return Animations
