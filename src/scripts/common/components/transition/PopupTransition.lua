local App = require('src.app')

local UIConfig = {
    animation_in = {
        duration = 0.5,
        duration_bg = 0.8,
        delay_bg = 0,
        easing = gui.EASING_OUTEXPO,
        easing_bg = gui.EASING_OUTEXPO,
    },
    animation_out = {
        duration = 0.35,
        duration_bg = 0.6,
        easing = gui.EASING_INEXPO,
        easing_bg = gui.EASING_INEXPO,
    },
}
local ConfigIn = UIConfig.animation_in
local ConfigOut = UIConfig.animation_out

local Transition = App.libs.transition

local GUI = require('gui.gui')
local BoxNode = GUI.BoxNode

local BACKGROUND = 'background'
local ROOT = 'root'

local PopupTransition = class('PopupTransition')

function PopupTransition:initialize()
    self.background = BoxNode(BACKGROUND)
    self.root = BoxNode(ROOT)

    self:init()
end

function PopupTransition:init()
    self.transition = Transition()

    self.transition:show_in({
        object = self.background,
        type = Transition.TYPE.FADE_IN,
        duration = ConfigIn.duration_bg,
        easing = ConfigIn.easing_bg,
        delay = ConfigIn.delay_bg,
    }):show_in({
        object = self.root,
        type = Transition.TYPE.SLIDE_IN_BOTTOM,
        duration = ConfigIn.duration,
        easing = ConfigIn.easing,
    })

    self.transition:show_out({
        object = self.background,
        type = Transition.TYPE.FADE_OUT,
        duration = ConfigOut.duration_bg,
        easing = ConfigOut.easing_bg,
    }):show_out({
        object = self.root,
        type = Transition.TYPE.SLIDE_OUT_BOTTOM,
        duration = ConfigOut.duration,
        easing = ConfigOut.easing,
    })

    self.transition:back_in({
        object = self.background,
        type = Transition.TYPE.FADE_IN,
        duration = ConfigIn.duration_bg,
        easing = ConfigIn.easing_bg,
        delay = ConfigIn.delay_bg,
    }):back_in({
        object = self.root,
        type = Transition.TYPE.SLIDE_IN_BOTTOM,
        duration = ConfigIn.duration,
        easing = ConfigIn.easing,
    })

    self.transition:back_out({
        object = self.background,
        type = Transition.TYPE.FADE_OUT,
        duration = ConfigOut.duration_bg,
        easing = ConfigOut.easing_bg,
    }):back_out({
        object = self.root,
        type = Transition.TYPE.SLIDE_OUT_BOTTOM,
        duration = ConfigOut.duration,
        easing = ConfigOut.easing,
    })

end

function PopupTransition:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function PopupTransition:final()
    self.transition:final()
end

return PopupTransition
