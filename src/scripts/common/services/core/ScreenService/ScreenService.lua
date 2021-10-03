local rendercam = require('rendercam.rendercam')
local Libs = require('src.libs.libs')
local Observable = Libs.event_observation.observable

local MSG_WINDOW_UPDATE = hash('window_update')

local ScreenService = {
    start_coords = nil,
    end_coords = nil,
    sizes = {},
    update_delay = 0.05,
    ON_RESIZE = 'screen_resize',
}

function ScreenService:init()
    self:add_listener(msg.url())

    self.init_observer = Observable()
    self.update_observer = Observable()

    self:_update_screen_size(function()
        self.init_observer:next()
        self.init_observer:complete()
    end)
end

function ScreenService:_update_screen_size(callback)
    self:_cancel_update_timer()

    self.timer_update_screen_size = timer.delay(self.update_delay, false, function()
        self.start_coords = rendercam.screen_to_world_2d(0, 0, false)
        self.end_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
        self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)

        if callback then
            callback()
        end
    end)
end

function ScreenService:_cancel_update_timer()
    if not self.timer_update_screen_size then
        return
    end

    timer.cancel(self.timer_update_screen_size)
    self.timer_update_screen_size = nil
end

function ScreenService:on_resize(cb)
    return self.update_observer:subscribe(self, cb)
end

function ScreenService:on_message(message_id)
    if message_id == MSG_WINDOW_UPDATE then
        self:update()
    end
end

function ScreenService:update()
    self:_update_screen_size(function()
        self.update_observer:next()
    end)
end

function ScreenService:get_sizes()
    return self.sizes
end

function ScreenService:get_window_size()
    return rendercam.window
end

function ScreenService:add_listener(url)
    rendercam.add_window_listener(url)
end

function ScreenService:remove_listener(url)
    rendercam.remove_window_listener(url)
end

function ScreenService:get_coords()
    return self.start_coords, self.end_coords
end

function ScreenService:screen_to_world_2d(pos, delta)
    return rendercam.screen_to_world_2d(pos.x, pos.y, delta)
end

function ScreenService:screen_to_gui(pos, adjust, is_size)
    local x, y = rendercam.screen_to_gui(pos.x, pos.y, adjust, is_size)

    return vmath.vector3(x, y, 0)
end

return ScreenService
