local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local PROP = App.constants.go_props
local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local Animations = class('Animations')

function Animations:initialize(id)
    local start_coords = ScreenService:get_coords()

    local anim_config = {
        property = PROP.position_y,
        to = start_coords.y,
        duration = App.config.game.boosts.animation.duration,
        easing = go.EASING_INCUBIC,
        playback = go.PLAYBACK_ONCE_FORWARD
    }

    self.anim_y = Animation:new(id, go.animate, go.cancel_animations, anim_config)
    self.animator = Animator:new()
end

function Animations:play()
    return self.animator:play(self.anim_y)
end

function Animations:cancel()
    self.animator:force_stop()
end

return Animations
