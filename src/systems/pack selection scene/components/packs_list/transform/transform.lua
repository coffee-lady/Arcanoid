local App = require('src.app')
local class = App.libs.middleclass

local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local ScrollConfig = App.config.common.gui.scroll
local PROP = App.constants.go_props

local animator = Animator:new()

local Transform = class('Transform')

local scroll_config = {
    property = PROP.position_y,
    duration = ScrollConfig.duration,
    easing = gui.EASING_LINEAR,
    delay = 0,
    playback = gui.PLAYBACK_ONCE_FORWARD
}

function Transform:initialize(list_node)
    self.node = list_node
    self.start_pos = gui.get_position(list_node)
end

function Transform:scroll(action, height)
    local pos = gui.get_position(self.node)
    pos.y = pos.y + action.dy

    scroll_config.to = pos.y

    if action.dy > 0 then
        if pos.y > self.start_pos.y then
            scroll_config.to = self.start_pos.y
        end

        local anim = Animation:new(self.node, gui.animate, gui.cancel_animation, scroll_config)

        animator:play(anim):finish()
    end

    if action.dy < 0 then
        if pos.y + height < 0 then
            scroll_config.to = -height
        end

        local anim = Animation:new(self.node, gui.animate, gui.cancel_animation, scroll_config)

        animator:play(anim):finish()
    end

end

return Transform
