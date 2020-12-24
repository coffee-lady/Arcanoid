local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass
local LevelService = Services.level

local LevelModel = class('LevelModel')

function LevelModel:initialize()
    self.next_level = LevelService:get_current_level()
    self.prev_level = self.next_level - 1
end

return LevelModel
