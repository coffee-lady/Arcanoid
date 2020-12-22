local App = require('src.app')
local monarch = require('monarch.monarch')
local Observable = App.libs.event_observation.observable

local ScenesService = {}

ScenesService.transitions = require('src.services.scenes.scenes_transitions.scenes_transitions')

local INIT_MONARCH = 'init_monarch'

function ScenesService:init()
    msg.post('#', INIT_MONARCH)
    self.init_observer = Observable:new()
end

function ScenesService:on_message(message_id)
    if message_id == hash(INIT_MONARCH) then
        self.init_observer:next()
        self.init_observer:complete()
    end
end

function ScenesService:post(screen_id, message_id, message)
    return monarch.post(screen_id, message_id, message)
end

function ScenesService:switch_to_scene(scene_id, scene_data, reload, callback)
    monarch.show(scene_id, {
        clear = true,
        reload = reload and reload or false,
        sequential = true
    }, scene_data, callback)
end

function ScenesService:back_to_prev_scene(scene_data, callback)
    monarch.back(scene_data, callback)
end

function ScenesService:is_visible(screen_id)
    return monarch.is_visible(screen_id)
end

function ScenesService:open_popup(popup_id, popup_data, callback)
    monarch.show(popup_id, {
        sequential = true
    }, popup_data, callback)
end

function ScenesService:close_popup(popup_id, callback)
    monarch.unload(popup_id, callback)
end

function ScenesService:get_scene_data(screen_id)
    return monarch.data(screen_id)
end

function ScenesService:add_listener(screen_id)
    monarch.add_listener(screen_id)
end

return ScenesService
