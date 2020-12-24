local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass
local LevelService = Services.level

local BottomPanel = class('BottomPanel')

function BottomPanel:initialize()
    self.current_level = LevelService:get_current_level()
    self.current_pack = LevelService:get_current_pack()
end

return BottomPanel
