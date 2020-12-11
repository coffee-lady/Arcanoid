local monarch = require('monarch.monarch')

local App = require('src.app')
local Observable = App.libs.event_observation.observable

local ScenesService = {}

ScenesService.transitions = require('src.services.scenes.scenes_transitions.scenes_transitions')

function ScenesService:init()
    msg.post("#", "init_monarch")
    self.init_observer = Observable:new()
end

function ScenesService:on_message(message_id)
    if message_id == hash('init_monarch') then
        self.init_observer:next()
        self.init_observer:complete()
	end
end

function ScenesService:switch_to_scene(scene_id, scene_data, reload, callback)
    monarch.show(scene_id, {
        clear = true,
        reload = reload and reload or false,
        sequential = true,
    }, scene_data, function()
        if callback then callback() end
    end)
end

function ScenesService:back_to_prev_scene(scene_data, callback)
    monarch.back(scene_data, function()
        if callback then callback() end
    end)
end

function ScenesService:open_popup(popup_id, popup_data, callback)
    monarch.show(popup_id, {
        clear = true,
        sequential = true,
    }, popup_data, function()
        if callback then callback() end
    end)
end

function ScenesService:close_popup(popup_id, callback)
    monarch.unload(popup_id, function()
        if callback then callback() end
    end)
end

function ScenesService:get_scene_data(screen_id)
    return monarch.data(screen_id)
end

function ScenesService:add_listener(screen_id)
    monarch.add_listener(screen_id)
end

return ScenesService
