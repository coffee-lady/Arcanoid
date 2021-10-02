local defsave = require('defsave.defsave')

local LocalStorage = {}

function LocalStorage:init(appname)
    defsave.appname = appname
    defsave.autosave = true
    defsave.autosave_timer = 1
    defsave.verbose = false
end

function LocalStorage:update(dt)
    defsave.update(dt)
end

function LocalStorage:set(filename, key, value)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end

    defsave.set(filename, key, value)
    defsave.save_all()
end

function LocalStorage:get(filename, key)
    if not defsave.is_loaded(filename) then
        defsave.load(filename)
    end

    if not key then
        return defsave.loaded[filename].data
    end

    return defsave.get(filename, key)
end

function LocalStorage:final()
    defsave.save_all()
end

return LocalStorage
