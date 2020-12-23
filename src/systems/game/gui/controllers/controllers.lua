local Controllers = {
    localization = require('src.systems.game.gui.controllers.localization.localization_controller'),
    lives = require('src.systems.game.gui.controllers.lives.lives_controller'),
    effects = require('src.systems.game.gui.controllers.effects.effects_controller'),
    overall = require('src.systems.game.gui.controllers.overall.overall_controller'),
    transitions = require('src.systems.game.gui.controllers.transitions.transitions')
}

return Controllers
