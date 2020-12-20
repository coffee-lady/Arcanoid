local class = require('src.libs.middleclass.middleclass')
local AnimationsLib = require('src.libs.animations.animations')

local Animator = AnimationsLib.animator
local ComplexAnimation = AnimationsLib.complex_animation

local Button = class('Button')

function Button:initialize(button)
    self._button = button
    self._color = gui.get_color(self._button)
    self._scale = gui.get_scale(button)
    self._is_pressed = false
    self._easing = gui.EASING_INCUBIC
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
        delay = 0
    })

    return anim
end

function Button:animate_click(blackout, delta_scale, duration, easing)
    self.animation_released = create_complex_anim(self._button, self._scale, self._color, duration, easing)

    local scale_to = vmath.vector3()
    scale_to.x = self._scale.x - delta_scale.x * self._scale.x
    scale_to.y = self._scale.y - delta_scale.y * self._scale.y

    local color_to = vmath.vector4()
    color_to.x = set_non_negative(self._color.x, blackout)
    color_to.y = set_non_negative(self._color.y, blackout)
    color_to.z = set_non_negative(self._color.z, blackout)

    self.animation_pressed = create_complex_anim(self._button, scale_to, color_to, duration, easing)
end

local function on_pressed(self)
    Animator():play(self.animation_pressed)

    self._is_pressed = true
end

local function on_released(self)
    Animator():play(self.animation_released)

    self._is_pressed = false
end

function Button:on_click(action)
    if action.pressed then
        if gui.pick_node(self._button, action.x, action.y) and not self._is_pressed then
            on_pressed(self)
        end
    end

    if action.released then
        if self._is_pressed then
            on_released(self)
        end
    end
end

return Button
