local rendercam = require('rendercam.rendercam')

local RENDERCAM_WINDOW_UPDATE = hash('window_update')

local ScreenService = {
    start_coords = nil,
    end_coords = nil,
    sizes = {},
    update_delay = 0.05,
    ON_RESIZE = 'screen_resize',
}

function ScreenService:init(callback)
    self:add_listener(msg.url())

    self:update(callback)
end

function ScreenService:on_message(message_id, callback)
    if message_id == RENDERCAM_WINDOW_UPDATE then
        self:update(callback)
    end
end

function ScreenService:update(callback)
    timer.delay(self.update_delay, false, function ()
        self.start_coords = rendercam.screen_to_world_2d(0, 0, false)
        self.end_coords = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, false)
        self.sizes = rendercam.screen_to_world_2d(rendercam.window.x, rendercam.window.y, true)
        if callback then callback() end
    end)
end

function ScreenService:get_sizes()
    return self.sizes
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

function ScreenService:screen_to_world_2d(pos)
    return rendercam.screen_to_world_2d(pos.x, pos.y, false)
end

return ScreenService
