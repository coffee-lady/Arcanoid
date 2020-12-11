local Observable = require('src.libs.event_observation.observable')

local function fork_join(...)
    local subscribers = { ... }
    local completed = 0
    local results = {}

    local subs = Observable:new()

    if #subscribers == 0 then return results end

    for i = 1, #subscribers do
        subscribers[i]:subscribe(function (value)
            completed = completed + 1
            table.insert(results, i, value)

            if completed == #subscribers then
                subs:next(results)
            end
        end)
    end

    return subs
end

return fork_join
