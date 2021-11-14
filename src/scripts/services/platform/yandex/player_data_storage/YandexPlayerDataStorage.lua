local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')
local json = require('defsave.json')

local Debug = App.libs.debug
local Array = App.libs.array

local YandexStorage = YandexAPI.YandexStorage

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_THEME = DataStorageConfig.keys.theme
local KEY_PREV_GAME = DataStorageConfig.keys.previous_game_data
local KEY_LANG = DataStorageConfig.keys.lang

local DEBUG = App.config.debug_mode.PlayerDataStorage

local SYNC_KEYS = {
    KEY_PREV_GAME,
    KEY_THEME,
    KEY_LANG
}

--- @class PlayerDataStorage
local YandexPlayerDataStorage = class('YandexPlayerDataStorage')

YandexPlayerDataStorage.__cparams = {'auth_service', 'local_storage'}

function YandexPlayerDataStorage:initialize(auth_service, local_storage)
    self.debug = Debug('[Yandex] PlayerDataStorage', DEBUG)

    self.data = {}
    self.auth_service = auth_service
    self.local_storage = local_storage
    self.yandex_storage = YandexStorage()

    self.is_online = true

    self:_load_data_from_server()
    self:_compare_data()
end

function YandexPlayerDataStorage:_load_data_from_server()
    if not self.auth_service:is_authorized() then
        self.debug:log('load_data_from_server failed: not authorized')
        return
    end

    self.data = self.yandex_storage:get_all_async()
end

function YandexPlayerDataStorage:on_online()
    self.is_online = true
    self:_compare_data()
end

function YandexPlayerDataStorage:on_offline()
    self.is_online = false
end

function YandexPlayerDataStorage:_compare_data()
    if not self.auth_service:is_authorized() then
        return
    end

    local local_data = {}
    local server_data = {}

    for i = 1, #SYNC_KEYS do
        local key = SYNC_KEYS[i]

        local_data[key] = self.local_storage:get(FILE, key)
        server_data[key] = self.data[self.yandex_storage:get_key(FILE, key)]
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

    self.local_storage:set(filename, key, value)
end

function YandexPlayerDataStorage:get(filename, key)
    local val

    if not self.auth_service:is_authorized() or not self.is_online then
        val = self.local_storage:get(filename, key)
    else
        val = self.data[self.yandex_storage:get_key(filename, key)]
    end

    return Array.deepcopy(val)
end

function YandexPlayerDataStorage:_update_from_local_data(local_data)
    for i = 1, #SYNC_KEYS do
        local key = SYNC_KEYS[i]
        self:_set_to_server_storage(FILE, key, local_data[key])
    end
end

function YandexPlayerDataStorage:_update_from_server_data(server_data)
    for i = 1, #SYNC_KEYS do
        local key = SYNC_KEYS[i]
        self.local_storage:set(FILE, key, server_data[key])
    end
end

function YandexPlayerDataStorage:_set_to_server_storage(filename, key, value)
    local data_key = self.yandex_storage:get_key(filename, key)
    local prev_data = Array.deepcopy(self.data)

    self.data[data_key] = value

    if json.encode(prev_data) == json.encode(self.data) then
        return
    end

    self.yandex_storage:set(self.data, filename, key, value)
end

return YandexPlayerDataStorage
