local App = require('src.app')
local LocalStorage = require('src.services.local_storage.local_storage')

local ResourcesService = App.libs.resources_storage

local GameConfig = App.config.game.go
local PacksConfig = App.config.game.packs
local GameRes = App.config.game.resources

local LEVELS = 'levels'
local CURRENT = 'current'
local PROGRESS = 'last_passed'
local PLAYED_LAST_LEVEL = 'played_last_level'

local LevelService = {}

local function _load_level_data(self)
    local filepath = GameRes:get_level_filepath(self.current_level)
    self.level_data = ResourcesService:get(filepath, GameRes.level_data.type)
end

local function _load_progress_level(self)
    local progress_level = LocalStorage:get(LEVELS, PROGRESS)

    LocalStorage:set(LEVELS, CURRENT, progress_level)

    self.current_level = progress_level

    _load_level_data(self)
end

local function _set_current_level(self, level)
    local progress_level = LocalStorage:get(LEVELS, PROGRESS)
    if not progress_level then
        progress_level = 1
    end

    self.current_level = level

    LocalStorage:set(LEVELS, CURRENT, self.current_level)

    if self.current_level > progress_level then
        LocalStorage:set(LEVELS, PROGRESS, self.current_level)
    end

    _load_level_data(self)
end

local function _load_current_pack(self)
    for i = 1, #PacksConfig.list do
        local first_level = PacksConfig.list[i].first_level
        local last_level = PacksConfig.list[i].last_level

        if first_level <= self.current_level and last_level >= self.current_level then
            self.current_pack = PacksConfig.list[i]
        end
    end
end

local function _set_level(self, level)
    _set_current_level(self, level)

    if not self.level_data then
        _set_current_level(self, level - 1)
        self.played_last_level = true
        LocalStorage:set(LEVELS, PLAYED_LAST_LEVEL, true)

        return false
    end

    local current = self.current_level
    local first_level = self.current_pack.first_level
    local last_level = self.current_pack.last_level

    if current < first_level or current > last_level then
        _load_current_pack(self)
    end

    return true
end

function LevelService:init()
    local current = LocalStorage:get(LEVELS, CURRENT)

    if not current then
        current = GameConfig.start_level
    end

    self.played_last_level = LocalStorage:get(LEVELS, PLAYED_LAST_LEVEL)
    self.current_level = current

    if not LocalStorage:get(LEVELS, PROGRESS) then
        LocalStorage:set(LEVELS, PROGRESS, 1)
    end

    _load_level_data(self)
    _load_current_pack(self)
end

function LevelService:switch_to_pack(pack)
    _set_level(self, pack.first_level)
    self.current_pack = pack
end

function LevelService:go_to_new_level()
    _load_progress_level(self)
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
    return self.current_pack
end

function LevelService:get_previous_pack()
    local previous_level = self.current_level - 1

    for i = 1, #PacksConfig.list do
        local first_level = PacksConfig.list[i].first_level
        local last_level = PacksConfig.list[i].last_level

        if first_level <= previous_level and last_level >= previous_level then
            return PacksConfig.list[i]
        end
    end
end

function LevelService:was_last_level_played()
    return self.played_last_level
end
function LevelService:get_last_level()
    return PacksConfig.list[#PacksConfig.list].last_level
end

return LevelService
