local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass

local ResourcesService = App.libs.resources_storage
local LocalStorage = Services.local_storage

local GameConfig = App.config.game.go
local GameRes = App.config.game.resources

local LEVELS = 'levels'
local CURRENT = 'current'

local Level = class('Level')

function Level:initialize(level)
    if level then
        self:set(level)
        self:_load_data()
        return
    end

    local current = LocalStorage:get(LEVELS, CURRENT)

    if not current then
        current = GameConfig.start_level
    end

    self.current_level = current
    self:_load_data()
end

function Level:_load_data()
    local filepath = GameRes:get_level_filepath(self.current_level)
    self.level_data = ResourcesService:get(filepath, GameRes.level_data.type)
end

function Level:set(level)
    self.current_level = level
    LocalStorage:set(LEVELS, CURRENT, self.current_level)
end

function Level:next()
    self:set(self.current_level + 1)
    self:_load_data()

    if not self.level_data then
        self:set(self.current_level - 1)
        return false
    end

    return true
end

function Level:get_data()
    return self.level_data
end

return Level
