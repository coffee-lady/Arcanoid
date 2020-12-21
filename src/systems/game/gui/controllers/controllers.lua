local Controllers = {
    localization = require('src.systems.game.gui.controllers.localization.localization_controller'),
    lives = require('src.systems.game.gui.controllers.lives.lives_controller'),
    effects = require('src.systems.game.gui.controllers.effects.effects_controller'),
    pause_button = require('src.systems.game.gui.controllers.pause_button.pause_button_controller')
}

return Controllers
