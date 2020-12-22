local defsave = require('defsave.defsave')

local LocalStorageService = {}

LocalStorageService.update_dt = 100

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
    return defsave.get(filename, key)
end

function LocalStorageService:final()
    defsave.save_all()
end

return LocalStorageService
