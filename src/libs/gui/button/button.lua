local class = require('src.libs.middleclass.middleclass')
local AnimationsLib = require('src.libs.animations.animations')

local Animator = AnimationsLib.animator
local ComplexAnimation = AnimationsLib.complex_animation

local Button = class('Button')

function Button:initialize(node, animation_config, on_click)
    self._button = node
    self._color = gui.get_color(self._button)
    self.scale = gui.get_scale(self._button)
    self._is_pressed = false
    self._easing = gui.EASING_INCUBIC
    self._on_click = on_click

    local A = animation_config
    self:animate_click(A.blackout, A.scale, A.duration, A.easing)
end

local function set_non_negative(prop, blackout)
    return prop - blackout > 0 and prop - blackout or 0
end

local function create_complex_anim(node, scale, color, duration, easing)
    local anim = ComplexAnimation:new(node, gui.animate, gui.cancel_animation, {{
        property = gui.PROP_SCALE,
        to = scale
    }, {
        property = gui.PROP_COLOR,
        to = color
    }})

    anim:set({
        duration = duration,
        easing = easing,
        playback = gui.PLAYBACK_ONCE_FORWARD,
        delay = 0
    })

    return anim
end

function Button:animate_click(blackout, scale, duration, easing)
    self.animation_released = create_complex_anim(self._button, self.scale, self._color, duration, easing)

    local color_to = vmath.vector4()
    color_to.x = set_non_negative(self._color.x, blackout)
    color_to.y = set_non_negative(self._color.y, blackout)
    color_to.z = set_non_negative(self._color.z, blackout)
    color_to.w = 1

    self.animation_pressed = create_complex_anim(self._button, scale, color_to, duration, easing)
end

function Button:on_click(action)
    local is_button_click = gui.pick_node(self._button, action.x, action.y)

    if action.pressed and is_button_click then
        Animator():play(self.animation_pressed)
        self._is_pressed = true
        return
    end

    if action.released then
        Animator():play(self.animation_released)

        if is_button_click and self._is_pressed then
            self._is_pressed = false

            if self._on_click then
                self._on_click()
            end
        end
    end
end

return Button
