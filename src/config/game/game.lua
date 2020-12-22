local GameConfig = {
    go = require('src.config.game.game objects.game_objects'),
    player = require('src.config.game.player.player'),
    gui = require('src.config.game.gui.gui'),
    resources = require('src.config.game.resources.resources_config'),

    delay_before_another_scene = 1
}

return GameConfig
