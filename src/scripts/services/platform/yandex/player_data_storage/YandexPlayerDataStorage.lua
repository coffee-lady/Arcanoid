local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')
local json = require('defsave.json')

local Debug = App.libs.debug
local Array = App.libs.array

local StorageAdapter = YandexAPI.PlayerDataStorage

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_THEME = DataStorageConfig.keys.theme
local KEY_PREV_GAME = DataStorageConfig.keys.previous_game_data
local KEY_LANG = DataStorageConfig.keys.lang

local DEBUG = App.config.debug_mode.PlayerDataStorage

local FILE_KEY_TO_OBJECT_KEY = {
    prev_game = KEY_PREV_GAME,
    theme = KEY_THEME,
    lang = KEY_LANG,
}

--- @class PlayerDataStorage
local YandexPlayerDataStorage = class('YandexPlayerDataStorage')

YandexPlayerDataStorage.__cparams = {'auth_service'}

function YandexPlayerDataStorage:initialize(auth_service)
    self.debug = Debug('[Yandex] PlayerDataStorage', DEBUG)

    self.data = {}
    self.auth_service = auth_service

    self.is_online = true

    self:load_data_from_server()
    self:compare_data()
end

function YandexPlayerDataStorage:load_data_from_server()
    if not self.auth_service:is_authorized() then
        self.debug:log('load_data_from_server failed: not authorized')
        return
    end

    self.data = StorageAdapter:get_data_from_server_async()
end

function YandexPlayerDataStorage:on_online()
    self.is_online = true
    self:compare_data()
end

function YandexPlayerDataStorage:on_offline()
    self.is_online = false
end

function YandexPlayerDataStorage:compare_data()
    if not self.auth_service:is_authorized() then
        return
    end

    local local_data = {}
    local server_data = {}

    for object_key, file_key in pairs(FILE_KEY_TO_OBJECT_KEY) do
        local_data[object_key] = StorageAdapter:get_from_local_storage(FILE, file_key)
        server_data[object_key] = self.data[StorageAdapter:get_key(FILE, file_key)]
    end

    local_data.rank = local_data.rank or 1
    server_data.rank = server_data.rank or 1
    local_data.points = local_data.points or 0
    server_data.points = server_data.points or 0
    local_data.mastery_timer = local_data.mastery_timer or 0
    server_data.mastery_timer = server_data.mastery_timer or 0

    if local_data.rank > server_data.rank or (local_data.rank == server_data.rank and local_data.points > server_data.points) then
        self.debug:log('update from local data. case: points')
        self:_update_from_local_data(local_data)
        return
    end

    if local_data.mastery_timer > server_data.mastery_timer then
        self.debug:log('update from local data. case: mastery_timer')
        self:_update_from_local_data(local_data)
        return
    end

    self.debug:log('update from server data')
    self:_update_from_server_data(server_data)
end

function YandexPlayerDataStorage:set(filename, key, value)
    local prev_value = self:get(filename, key)
    value = Array.deepcopy(value)

    if json.encode(prev_value) == json.encode(value) then
        return
    end

    if self.auth_service:is_authorized() and self.is_online then
        self:_set_to_server_storage(filename, key, value)
    end

    StorageAdapter:set_to_local_storage(filename, key, value)
end

function YandexPlayerDataStorage:get(filename, key)
    local val

    if not self.auth_service:is_authorized() or not self.is_online then
        val = StorageAdapter:get_from_local_storage(filename, key)
    else
        val = self.data[StorageAdapter:get_key(filename, key)]
    end

    return Array.deepcopy(val)
end

function YandexPlayerDataStorage:_update_from_local_data(local_data)
    for object_key, file_key in pairs(FILE_KEY_TO_OBJECT_KEY) do
        self:_set_to_server_storage(FILE, file_key, local_data[object_key])
    end
end

function YandexPlayerDataStorage:_update_from_server_data(server_data)
    for object_key, file_key in pairs(FILE_KEY_TO_OBJECT_KEY) do
        StorageAdapter:set_to_local_storage(FILE, file_key, server_data[object_key])
    end
end

function YandexPlayerDataStorage:_set_to_server_storage(filename, key, value)
    local data_key = StorageAdapter:get_key(filename, key)
    local prev_data = Array.deepcopy(self.data)

    self.data[data_key] = value

    if json.encode(prev_data) == json.encode(self.data) then
        return
    end

    StorageAdapter:set_to_server_storage(self.data, filename, key, value)
end

return YandexPlayerDataStorage
