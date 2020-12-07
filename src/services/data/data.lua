local defsave = require('defsave.defsave')

local DataService = {}

function DataService:init(appname)
    defsave.appname = appname
    defsave.autosave = true
end

function DataService:set(filename, key, value)
    defsave.load(filename)
    defsave.set(filename, key, value)
end

function DataService:get(filename, key)
    defsave.load(filename)
    defsave.get(filename, key)
end

return DataService
