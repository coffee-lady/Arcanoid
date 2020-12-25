local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass
local LevelService = Services.level

local BottomPanel = class('BottomPanel')

function BottomPanel:initialize()
    self.progress_level = LevelService:get_progress_level()
    self.current_pack = LevelService:get_current_pack()
end

return BottomPanel
