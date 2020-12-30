local Boosts = {
    ball_acceleration = require('src.systems.game.components.boosts.ball.ball_acceleration'),
    captive_ball = require('src.systems.game.components.boosts.ball.captive_ball'),
    ball_deceleration = require('src.systems.game.components.boosts.ball.ball_deceleration'),
    fireball = require('src.systems.game.components.boosts.ball.fireball'),

    extend_platform = require('src.systems.game.components.boosts.platform.extend_platform'),
    platform_acceleration = require('src.systems.game.components.boosts.platform.platform_acceleration'),
    platform_deceleration = require('src.systems.game.components.boosts.platform.platform_deceleration'),
    shorten_platform = require('src.systems.game.components.boosts.platform.shorten_platform'),

    bonus_life = require('src.systems.game.components.boosts.lives.bonus_life'),
    black_label = require('src.systems.game.components.boosts.lives.black_label'),

    simple_bomb = require('src.systems.game.components.boosts.bombs.simple_bomb'),
    color_bomb = require('src.systems.game.components.boosts.bombs.color_bomb'),
    horizontal_bomb = require('src.systems.game.components.boosts.bombs.horizontal_bomb'),
    vertical_bomb = require('src.systems.game.components.boosts.bombs.vertical_bomb'),

    empty = require('src.systems.game.components.boosts.empty.empty')
}

return Boosts
