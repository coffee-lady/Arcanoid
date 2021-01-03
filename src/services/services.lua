local energy = require "src.systems.game.components.energy.energy"
local Services = {
    scenes = require('src.services.scenes.scenes'),
    screen = require('src.services.screen.screen'),
    localization = require('src.services.localization.localization'),
    local_storage = require('src.services.local_storage.local_storage'),
    level = require('src.services.level.level'),
    energy = require('src.services.energy.energy'),
    gui = require('src.services.gui.gui')
}

return Services
