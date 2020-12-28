local GameConfig = {
    go = require('src.config.game.game objects.game_objects'),
    gui = require('src.config.game.gui.gui'),
    packs = require('src.config.game.packs.packs'),
    resources = require('src.config.game.resources.resources_config'),
    boosts = require('src.config.game.boosts.boosts'),

    delay_before_another_scene = 1
}

return GameConfig
