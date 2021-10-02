local App = require('src.app')

local UIConfig = App.config.ui.transitions.screen

local Transition = App.libs.transition

local GUI = require('gui.gui')
local BoxNode = GUI.BoxNode

local CONFIG = {
    show_in = {
        type = Transition.TYPE.FADE_IN,
        duration = UIConfig.duration,
        easing = UIConfig.easing,
    },
    show_out = {
        type = Transition.TYPE.FADE_OUT,
        duration = UIConfig.duration,
        easing = UIConfig.easing,
    },
    back_in = {
        type = Transition.TYPE.FADE_IN,
        duration = UIConfig.duration,
        easing = UIConfig.easing,
    },
    back_out = {
        type = Transition.TYPE.FADE_OUT,
        duration = UIConfig.duration,
        easing = UIConfig.easing,
    },
}

local ROOT = 'root'

local ScreenTransition = class('ScreenTransition')

function ScreenTransition:initialize(params)
    self.root = BoxNode(ROOT)

    params = params or {}

    self:enable(params)
end

function ScreenTransition:enable(params)
    self.transition = Transition(self.root)

    for key, config in pairs(CONFIG) do
        if not params['disable_' .. key] then
            self.transition[key](self.transition, config)
        end
    end
end

function ScreenTransition:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function ScreenTransition:skip(screen_id)
    self.transition:skip(screen_id)
end

function ScreenTransition:final()
    self.transition:final()
end

return ScreenTransition
