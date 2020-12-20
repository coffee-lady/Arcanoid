local Models = require('src.systems.game.go.models.models')

local Level = Models.level

local LevelController = {}

function LevelController:init()
    self.current_level = Level:new(1)
end

function LevelController:get_data()
    return self.current_level:get_data()
end

return LevelController
