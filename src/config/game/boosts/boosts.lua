local BoostsConfig = {
    ball_acceleration = require('src.config.game.boosts.ball.boost_ball_acceleration'),
    ball_deceleration = require('src.config.game.boosts.ball.boost_ball_deceleration'),
    captive_ball = require('src.config.game.boosts.ball.boost_captive_ball'),
    fireball = require('src.config.game.boosts.ball.boost_fireball'),
    bomb = require('src.config.game.boosts.bombs.boost_bomb'),
    color_bomb = require('src.config.game.boosts.bombs.boost_color_bomb'),
    horizontal_bomb = require('src.config.game.boosts.bombs.boost_horizontal_bomb'),
    vertical_bomb = require('src.config.game.boosts.bombs.boost_vertical_bomb'),
    black_label = require('src.config.game.boosts.lives.boost_black_label'),
    life = require('src.config.game.boosts.lives.boost_life'),
    extend_platform = require('src.config.game.boosts.platform.boost_extend_platform'),
    platform_acceleration = require('src.config.game.boosts.platform.boost_platform_acceleration'),
    platform_deceleration = require('src.config.game.boosts.platform.boost_platform_deceleration'),
    shorten_platform = require('src.config.game.boosts.platform.boost_shorten_platform'),

    animation = {
        duration = 2
    }
}

return BoostsConfig
