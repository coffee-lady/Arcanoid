local Controllers = {
    localization = require('src.systems.pack selection scene.gui.controllers.localization.localization_controller'),
    lives = require('src.systems.pack selection scene.gui.controllers.lives.lives_controller'),
    effects = require('src.systems.pack selection scene.gui.controllers.effects.effects_controller'),
    overall = require('src.systems.pack selection scene.gui.controllers.overall.overall_controller'),
    transitions = require('src.systems.pack selection scene.gui.controllers.transitions.transitions')
}

return Controllers
