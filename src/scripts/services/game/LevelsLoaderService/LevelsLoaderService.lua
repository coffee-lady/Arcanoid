local App = require('src.app')

local ResourcesStorage = App.libs.resources_storage

local ResourcesConfig = App.config.resources
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_CURRENT_LEVEL = DataStorageConfig.keys.current_level
local KEY_PROGRESS_LEVEL = DataStorageConfig.keys.progress_level

--- @class LevelsLoaderService
local LevelsLoaderService = class('LevelsLoaderService')

LevelsLoaderService.__cparams = {'player_data_storage'}

function LevelsLoaderService:initialize(player_data_storage)
    --- @type ServerDataStorage
    self.player_data_storage = player_data_storage
end

function LevelsLoaderService:load_level(level_index)
    local filepath = string.format(ResourcesConfig.levels, level_index)
    return ResourcesStorage:get_json_data(filepath)
end

return LevelsLoaderService
