local Models = {
    ball = require('src.systems.game.go.models.ball.ball_model'),
    block_builder = require('src.systems.game.go.models.blocks.block_model_builder'),
    platform = require('src.systems.game.go.models.platform.platform_model'),
    losing_zone = require('src.systems.game.go.models.losing_zone.losing_zone_model')
}

return Models
