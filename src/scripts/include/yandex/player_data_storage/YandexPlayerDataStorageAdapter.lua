local App = require('src.app')
local yagames = require('yagames.yagames')

local Debug = App.libs.debug
local Async = App.libs.async

local DEBUG = App.config.debug_mode.PlayerDataStorage

local debug_logger = Debug('[Yandex] PlayerDataStorageAdapter', DEBUG)

local YandexPlayerDataStorageAdapter = {}

function YandexPlayerDataStorageAdapter:init(local_storage)
    self.local_storage = local_storage
end

function YandexPlayerDataStorageAdapter:get_data_from_server_async()
    return Async(function(done)
        yagames.player_get_data(nil, function(_, err, result)
            if err then
                debug_logger:log('ERROR while getting player data:', err)
                return
            end

            debug_logger:log('load all data from server =', debug_logger:inspect(result))

            done(result)
        end)
    end)
end

function YandexPlayerDataStorageAdapter:set_to_local_storage(filename, key, value)
    debug_logger:log('set', filename, key, value, 'to local storage')
    self.local_storage:set(filename, key, value)
end

function YandexPlayerDataStorageAdapter:set_to_server_storage(data_object, filename, key, value)
    yagames.player_set_data(data_object, true, function(_, err)
        if err then
            debug_logger:log('ERROR on set data', err)
            return
        end

        debug_logger:log('set', filename, key, debug_logger:inspect(value), 'to yandex server')
    end)
end

function YandexPlayerDataStorageAdapter:get_from_local_storage(filename, key)
    local value = self.local_storage:get(filename, key)

    debug_logger:log('get', filename, key, '=', debug_logger:inspect(value), 'from local storage')

    return value
end

function YandexPlayerDataStorageAdapter:get_key(filename, key)
    return filename .. key
end

return YandexPlayerDataStorageAdapter
