local defsave = require('defsave.defsave')

local LocalStorageService = {}

LocalStorageService.update_dt = 1000

function LocalStorageService:init(appname)
    defsave.appname = appname
    defsave.autosave = true
    defsave.update(self.update_dt)
end

function LocalStorageService:set(filename, key, value)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end
    defsave.set(filename, key, value)
end

function LocalStorageService:get(filename, key)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end
    defsave.get(filename, key)
end

function LocalStorageService:get_json_resource(filename, key)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end
    defsave.get(filename, key)
end

return LocalStorageService
