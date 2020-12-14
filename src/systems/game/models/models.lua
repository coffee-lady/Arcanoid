local GameModels = {
    ball = require('src.systems.game.models.ball.ball_model'),
    block_builder = require('src.systems.game.models.blocks.block_builder_model'),
    level = require('src.systems.game.models.level.level_model'),
    platform = require('src.systems.game.models.platform.platform_model'),
    lives = require('src.systems.game.models.lives.lives_model')
}

return GameModels
