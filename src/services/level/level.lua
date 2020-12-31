local App = require('src.app')
local LocalStorage = require('src.services.local_storage.local_storage')

local ResourcesService = App.libs.resources_storage

local PackData = require('src.services.level.internal.pack')
local GameConfig = App.config.game.go
local GameRes = App.config.game.resources

local LEVELS = 'levels'
local CURRENT = 'current'
local PROGRESS = 'last_passed'
local PLAYED_LAST_LEVEL = 'played_last_level'

local LevelService = {}

local function _load_level(self, level)
    self.current_level = level

    LocalStorage:set(LEVELS, CURRENT, self.current_level)

    local filepath = GameRes:get_level_filepath(level)
    self.level_data = ResourcesService:get(filepath, GameRes.level_data.type)

    PackData:load_pack_by_level(self.current_level)
end

local function _set_level(self, level)
    _load_level(self, level)

    if not self.level_data then
        _load_level(self, level - 1)
        self.played_last_level = true
        LocalStorage:set(LEVELS, PLAYED_LAST_LEVEL, true)

        return false
    end

    if level > LocalStorage:get(LEVELS, PROGRESS) then
        LocalStorage:set(LEVELS, PROGRESS, level)
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

function LevelService:init()
    local level = LocalStorage:get(LEVELS, PROGRESS)

    if not level then
        level = GameConfig.start_level
    end

    self.played_last_level = LocalStorage:get(LEVELS, PLAYED_LAST_LEVEL)

    if not LocalStorage:get(LEVELS, PROGRESS) then
        LocalStorage:set(LEVELS, PROGRESS, 1)
    end

    _set_level(self, level)
end

function LevelService:switch_to_pack(pack)
    _set_level(self, pack.first_level)
end

function LevelService:go_to_new_level()
    local progress_level = LocalStorage:get(LEVELS, PROGRESS)

    return _set_level(self, progress_level)
end

function LevelService:go_to_next_level()
    return _set_level(self, self.current_level + 1)
end

function LevelService:get_data()
    return self.level_data
end

function LevelService:get_progress_level()
    return LocalStorage:get(LEVELS, PROGRESS)
end

function LevelService:get_current_level()
    return self.current_level
end

function LevelService:get_current_pack()
    return PackData:get_current_pack()
end

function LevelService:get_previous_pack()
    return PackData:get_previous_pack()
end

function LevelService:was_last_level_played()
    return self.played_last_level
end
function LevelService:get_last_level()
    return PackData:get_last_level()
end

return LevelService
