local Animations = require('animations.animations')

--- @class AnimatedThemeObject
local AnimatedThemeObject = class('AnimatedThemeObject')

--- @param elems table <string, Node | NodesList >
function AnimatedThemeObject:initialize(elems, theme, primary_mode)
    self.nodes = elems
    self.theme = theme

    self.PRIMARY_MODE = primary_mode or 'primary'
    self.ERROR_MODE = 'error'

    self.MODE = {}
    self.SUBMODE = {}

    for key, _ in pairs(self.theme) do
        self.MODE[key] = key
    end

    for mode, value in pairs(self.theme) do
        self.MODE[mode] = mode

        if type(value) == 'table' then
            for submode, _ in pairs(value) do
                self.SUBMODE[submode] = submode
            end
        end
    end

    self.colors = self.theme[self.PRIMARY_MODE]
    self.current_mode = self.PRIMARY_MODE
    self.current_submode = self.SUBMODE.base
end

function AnimatedThemeObject:init(disable_submode)
    self.disable_submode = disable_submode

    return self
end

function AnimatedThemeObject:animate(mode, duration, easing, playback)
    assert(self.MODE[mode] or self.SUBMODE[mode], 'AnimatedThemeObject animation: no such mode or submode')

    local colors = self.disable_submode and self.theme[mode] or self.colors[mode]
    local seq = Animations.Sequence()

    self:_animate_nodes_to(seq, colors, duration, easing, playback)

    return seq
end

function AnimatedThemeObject:animate_transitions(mode, duration, easing, playback)
    assert(self.MODE[mode] or self.SUBMODE[mode], 'AnimatedThemeObject animation: no such mode or submode')

    local colors = self.disable_submode and self.theme[mode] or self.colors[mode]
    local seq = Animations.Sequence()

    local duration_item = duration / #colors

    for i = 1, #colors do
        local subseq = Animations.Sequence()

        self:_animate_nodes_to(subseq, colors[i], duration_item, easing, playback)

        seq:add(subseq)
    end

    return seq
end

function AnimatedThemeObject:_animate_nodes_to(seq, colors, duration, easing, playback)
    for key, object in pairs(self.nodes) do
        local color = colors[key]

        if color then
            local tween = object:animate_color_to(color, duration)

            if easing then
                tween:easing(easing)
            end

            if playback then
                tween:playback(playback)
            end

            seq:join(tween)
        end
    end
end

return AnimatedThemeObject
