local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass

local ResourcesService = App.libs.resources_storage
local LocalStorage = Services.local_storage

local GameConfig = App.config.game
local GameRes = GameConfig.resources

local Level = class('Level')

function Level:initialize(level)
    if level then
        self:set(level)
        return
    end

    local current = LocalStorage:get('levels', 'current')
    if not current then
        current = GameConfig.start_level
    end

    self:set(current)
end

function Level:_load_data()
    local filepath = GameRes:get_level_filepath(self.current_level)
    self.level_data = ResourcesService:get(filepath, GameRes.level_data.type)
end

function Level:set(level)
    self.current_level = level
    LocalStorage:set('levels', 'current', self.current)

    self:_load_data()
end

function Level:get_data()
    return self.level_data
end

return Level
