local GameGOConfig = {
    blocks = require('src.config.game.game objects.blocks_config'),
    ball = require('src.config.game.game objects.ball_config'),
    platform = require('src.config.game.game objects.platform_config'),
    walls = require('src.config.game.game objects.walls_config'),
    losing_zone = require('src.config.game.game objects.losing_zone_config'),
    energy = require('src.config.game.game objects.energy_config'),

    start_level = 1
}

return GameGOConfig
