local App = require('src.app')

local URL = App.constants.urls

--- @class GlobalGUICallerService
local GlobalGUICallerService = class('GlobalGUICallerService')

GlobalGUICallerService.__cparams = {'scenes_service'}

function GlobalGUICallerService:initialize(scenes_service)
    self.scenes_service = scenes_service
    self.callbacks = {}
end

function GlobalGUICallerService:set_callback(id, callback)
    self.callbacks[id] = callback
end

function GlobalGUICallerService:call(id, params)
    self.scenes_service:post_to_gui(URL.bootstrap, id, params)
end

function GlobalGUICallerService:_bootstrap_on(id, params)
    if self.callbacks[id] then
        self.callbacks[id](params)
    end
end

return GlobalGUICallerService
