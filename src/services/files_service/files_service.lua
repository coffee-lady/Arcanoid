local defsave = require('defsave.defsave')

local FilesService = {}

FilesService.update_dt = 1000

function FilesService:init(appname)
    defsave.appname = appname
    defsave.autosave = true
    defsave.update(self.update_dt)
end

function FilesService:set(filename, key, value)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end
    defsave.set(filename, key, value)
end

function FilesService:get(filename, key)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end
    defsave.get(filename, key)
end

return FilesService
