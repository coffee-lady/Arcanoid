local App = require('src.app')

local ResourcesStorage = App.libs.resources_storage

local ResourcesConfig = App.config.resources
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_CURRENT_LEVEL = DataStorageConfig.keys.current_level
local KEY_PROGRESS_LEVEL = DataStorageConfig.keys.progress_level

--- @class LevelsService
local LevelsService = class('LevelsService')

LevelsService.__cparams = {'player_data_storage'}

function LevelsService:initialize(player_data_storage)
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage

    self.progress_level = self.player_data_storage:get(FILE, KEY_PROGRESS_LEVEL) or 1
    self.current_level = self.player_data_storage:get(FILE, KEY_CURRENT_LEVEL) or 1
end

function LevelsService:get_level(level_index)
    self.current_level = level_index
    self.player_data_storage:set(FILE, KEY_CURRENT_LEVEL, level_index)

    if level_index > self.progress_level then
        self.player_data_storage:set(FILE, KEY_PROGRESS_LEVEL, level_index)
        self.progress_level = level_index
    end

    local filepath = string.format(ResourcesConfig.levels, level_index)
    return ResourcesStorage:get_json_data(filepath)
end

function LevelsService:get_current_level()
    return self:get_level(self.current_level)
end

function LevelsService:get_next_level()
    return self:get_level(self.current_level + 1)
end

function LevelsService:get_progress_level_index()
    return self.progress_level
end

function LevelsService:get_current_level_index()
    return self.current_level
end

return LevelsService
