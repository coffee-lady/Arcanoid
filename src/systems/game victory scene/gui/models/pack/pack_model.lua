local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass
local LevelService = Services.level

local PackModel = class('PackView')

function PackModel:initialize()
    self.prev_pack = LevelService:get_previous_pack()
    self.next_pack = LevelService:get_current_pack()
end

return PackModel
