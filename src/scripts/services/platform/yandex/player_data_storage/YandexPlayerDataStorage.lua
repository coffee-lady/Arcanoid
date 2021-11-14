local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')

local Array = App.libs.array
local JSON = App.libs.json

local YandexStorage = YandexAPI.YandexStorage

--- @class ServerDataStorage
local YandexPlayerDataStorage = class('ServerDataStorage')

YandexPlayerDataStorage.__cparams = {'auth_service', 'local_storage'}

function YandexPlayerDataStorage:initialize(auth_service, local_storage)
    self.data = {}
    self.auth_service = auth_service
    self.local_storage = local_storage
    self.yandex_storage = YandexStorage()

    self.is_online = true

    self:_load_data()
end

function YandexPlayerDataStorage:_load_data()
    self.data = self.yandex_storage:get_all_async()
end

function YandexPlayerDataStorage:get(filename, key)
    local val = self.data[self.yandex_storage:get_key(filename, key)]
    return Array.deepcopy(val)
end

function YandexPlayerDataStorage:set(filename, key, value)
    local data_key = self.yandex_storage:get_key(filename, key)

    if JSON.encode(self.data[data_key]) == JSON.encode(value) then
        return
    end

    self.data[data_key] = value
    self.yandex_storage:set(self.data, filename, key, value)
end

return YandexPlayerDataStorage
