local App = require('src.app')

local ResourcesService = App.libs.resources_storage

local GameConfig = App.config.game.go
local GameRes = App.config.game.resources

local LEVELS = 'levels'
local CURRENT = 'current'
local PROGRESS = 'last_passed'
local PLAYED_LAST_LEVEL = 'played_last_level'

local LevelsService = class('LevelsService')

LevelsService.__cparams = {'player_data_storage'}

function LevelsService:initialize(player_data_storage)
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage

    local level = self.player_data_storage:get(LEVELS, PROGRESS)

    if not level then
        level = GameConfig.start_level
    end

    self.played_last_level = self.player_data_storage:get(LEVELS, PLAYED_LAST_LEVEL)

    if not self.player_data_storage:get(LEVELS, PROGRESS) then
        self.player_data_storage:set(LEVELS, PROGRESS, 1)
    end

    self:_set_level(self, level)
end

function LevelsService:switch_to_pack(pack)
    self:_set_level(self, pack.first_level)
end

function LevelsService:go_to_new_level()
    local progress_level = self.player_data_storage:get(LEVELS, PROGRESS)

    return self:_set_level(self, progress_level)
end

function LevelsService:_load_level(level)
    self.current_level = level

    self.player_data_storage:set(LEVELS, CURRENT, self.current_level)

    local filepath = GameRes:get_level_filepath(level)
    self.level_data = ResourcesService:get(filepath, GameRes.level_data.type)

    PackData:load_pack_by_level(self.current_level)
end

function LevelsService:_set_level(level)
    self:_load_level(self, level)

    if not self.level_data then
        self:_load_level(self, level - 1)
        self.played_last_level = true
        self.player_data_storage:set(LEVELS, PLAYED_LAST_LEVEL, true)

        return false
    end

    if level > self.player_data_storage:get(LEVELS, PROGRESS) then
        self.player_data_storage:set(LEVELS, PROGRESS, level)
    end

    local current = self.current_level
    local current_pack = PackData:get_current_pack()
    local first_level = current_pack.first_level
    local last_level = current_pack.last_level

    if current < first_level or current > last_level then
        PackData:load_pack_by_level(self.current_level)
    end

    return true
end

function LevelsService:go_to_next_level()
    return self:_set_level(self, self.current_level + 1)
end

function LevelsService:get_data()
    return self.level_data
end

function LevelsService:get_progress_level()
    return self.player_data_storage:get(LEVELS, PROGRESS)
end

function LevelsService:get_current_level()
    return self.current_level
end

function LevelsService:get_current_pack()
    return PackData:get_current_pack()
end

function LevelsService:get_previous_pack()
    return PackData:get_pack(self.current_level - 1)
end

function LevelsService:get_progress_pack()
    return PackData:get_pack(self.player_data_storage:get(LEVELS, PROGRESS))
end

function LevelsService:was_last_level_played()
    return self.played_last_level
end
function LevelsService:get_last_level()
    return PackData:get_last_level()
end

return LevelsService
