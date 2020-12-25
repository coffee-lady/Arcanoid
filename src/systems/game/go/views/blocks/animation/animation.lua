local App = require('src.app')
local Services = require('src.services.services')
local ScreenService = Services.screen

local Config = App.config
local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local PROP = App.constants.go_props

local start_coords = ScreenService:get_coords()

local sprite_pos_y_anim = {
    property = PROP.position_y,
    to = start_coords.y,
    duration = Config.game.go.blocks.sprite_falling_duration,
    easing = go.EASING_INCUBIC,
    playback = go.PLAYBACK_ONCE_FORWARD
}

local BlockAnimation = {}

function BlockAnimation:animate_cracks(cracks_url)
    msg.post(cracks_url, PROP.enable)
end

function BlockAnimation:animate_sprite(url, cracks_url)
    local co_url = msg.url(nil, url, PROP.collisionobject)
    local top_s = msg.url(nil, url, PROP.block.snowglobe_top)
    local bottom_s = msg.url(nil, url, PROP.block.snowglobe_bottom)

    msg.post(co_url, PROP.disable)
    msg.post(top_s, PROP.disable)
    msg.post(bottom_s, PROP.disable)
    msg.post(cracks_url, PROP.disable)

    local anim_y = Animation:new(url, go.animate, go.cancel_animations, sprite_pos_y_anim)

    return Animator():play(anim_y)
end

function BlockAnimation:animate_breaking(pfx_url, cb)
    particlefx.play(pfx_url, cb)
end

return BlockAnimation
