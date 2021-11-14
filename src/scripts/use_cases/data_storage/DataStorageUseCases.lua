local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')
local MergeStoragesUseCase = require('src.scripts.use_cases.data_storage.helpers.MergeStoragesUseCase')

local Array = App.libs.array
local Luject = App.libs.luject

--- @class DataStorageUseCases
local DataStorageUseCases = class('DataStorageUseCases')

DataStorageUseCases.__cparams = {'auth_service', 'local_storage', 'server_data_storage'}

function DataStorageUseCases:initialize(auth_service, local_storage, server_data_storage)
    --- @type AuthService
    self.auth_service = auth_service
    --- @type LocalStorage
    self.local_storage = local_storage
    --- @type ServerDataStorage
    self.server_data_storage = server_data_storage

    --- @type MergeStoragesUseCase
    self.merge_storages_use_case = Luject:resolve_class(MergeStoragesUseCase)

    self.is_online = true

    self.merge_storages_use_case:merge_storages()
end

function DataStorageUseCases:on_online()
    self.is_online = true
    self.merge_storages_use_case:merge_storages()
end

function DataStorageUseCases:on_offline()
    self.is_online = false
end

function DataStorageUseCases:set(filename, key, value)
    if self:_is_already_set_value(filename, key, value) then
        return
    end

    self:_try_set_to_server(filename, key, value)
    self.local_storage:set(filename, key, value)
end

function DataStorageUseCases:get(filename, key)
    local can_get_from_server = self.auth_service:is_authorized() and self.is_online

    if can_get_from_server then
        return self.server_data_storage:get(filename, key)
    end

    return self.local_storage:get(filename, key)
end

function DataStorageUseCases:_is_already_set_value(filename, key, value)
    local prev_value = self:get(filename, key)
    return json.encode(prev_value) == json.encode(value)
end

function DataStorageUseCases:_try_set_to_server(filename, key, value)
    local can_set_to_server = self.auth_service:is_authorized() and self.is_online

    if can_set_to_server then
        self.server_data_storage:set(filename, key, value)
    end
end

return DataStorageUseCases
