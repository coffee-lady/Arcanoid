local localization = require "src.config.localization.localization"
local Controllers = {
    localization = require('src.systems.game.gui.controllers.localization.localization_controller'),
    lives = require('src.systems.game.gui.controllers.lives.lives_controller'),
    pause_button = require('src.systems.game.gui.controllers.pause_button.pause_button_controller')
}

return Controllers
