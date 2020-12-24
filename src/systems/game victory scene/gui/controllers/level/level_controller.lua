local Models = require('src.systems.game victory scene.gui.models.models')
local Views = require('src.systems.game victory scene.gui.views.views')

local Level = Models.level
local LevelView = Views.level

local LevelController = {}

function LevelController:init()
    self.level = Level:new()
    self.level_view = LevelView:new(self.level.prev_level, self.level.next_level)
end

return LevelController
