local GameGOConfig = {
    blocks = require('src.config.game.game objects.blocks'),
    ball = require('src.config.game.game objects.ball'),
    platform = require('src.config.game.game objects.platform'),
    walls = require('src.config.game.game objects.walls'),
    losing_zone = require('src.config.game.game objects.losing_zone'),
    energy = require('src.config.game.game objects.energy'),
    lives = require('src.config.game.game objects.lives'),

    start_level = 1
}

return GameGOConfig
