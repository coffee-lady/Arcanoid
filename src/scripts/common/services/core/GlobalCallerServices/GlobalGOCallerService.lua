local App = require('src.app')

local URL = App.constants.urls

local unpack = _G.unpack or table.unpack

local GlobalGOCallerService = {}

function GlobalGOCallerService:init(scenes_service)
    self.scenes_service = scenes_service
    self.callbacks = {}
end

function GlobalGOCallerService:set_callback(id, callback)
    self.callbacks[id] = callback
end

function GlobalGOCallerService:call(id, ...)
    self.scenes_service:post_to_go(URL.bootstrap, id, {...})
end

function GlobalGOCallerService:_bootstrap_on(id, params)
    if self.callbacks and self.callbacks[id] then
        self.callbacks[id](unpack(params))
    end
end

return GlobalGOCallerService
