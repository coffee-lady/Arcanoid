local class = require('src.libs.middleclass.middleclass')
local monarch = require('monarch.monarch')
local transitions = require('monarch.transitions.gui')

local ScenesTransitions = class('ScenesTransitions')

ScenesTransitions.TRANSITIONS_CONST = {
    slide_in_right = transitions.slide_in_right,
    slide_in_left = transitions.slide_in_left,
    slide_in_top = transitions.slide_in_top,
    slide_in_bottom = transitions.slide_in_bottom,
    slide_out_right = transitions.slide_out_right,
    slide_out_left = transitions.slide_out_left,
    slide_out_top = transitions.slide_out_top,
    slide_out_bottom = transitions.slide_out_bottom,
    scale_in = transitions.scale_in,
    scale_out = transitions.scale_out,
    fade_in = transitions.fade_in,
    fade_out = transitions.fade_out
}

ScenesTransitions.NAVIGATION = {
    show_in = 'show_in',
    show_out = 'show_out',
    back_in = 'back_in',
    back_out = 'back_out'
}

function ScenesTransitions:initialize(node_url, config)
    self.transition = transitions.create(gui.get_node(node_url))
    monarch.add_listener(msg.url())

    self.config = config
end

function ScenesTransitions:auto_set(settings)
    local NAV = ScenesTransitions.NAVIGATION
    self.config = settings.config

    self:set(NAV.show_in, settings.trans_in)
    self:set(NAV.show_out, settings.trans_out)
    self:set(NAV.back_in, settings.trans_in)
    self:set(NAV.back_out, settings.trans_out)
end

function ScenesTransitions:set(navigation, transition, easing, duration, delay)
    easing = easing and easing or self.config.easing
    duration = duration and duration or self.config.duration
    delay = delay and delay or self.config.delay

    self.transition[navigation](transition, easing, duration, delay)
end

function ScenesTransitions:final()
    monarch.remove_listener(msg.url())
end

function ScenesTransitions:on_message(message_id, message, sender)
    self.transition.handle(message_id, message, sender)
end

return ScenesTransitions
