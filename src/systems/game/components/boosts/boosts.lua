local Boosts = {
    ball_acceleration = require('src.systems.game.components.boosts.ball_acceleration.ball_acceleration'),
    captive_ball = require('src.systems.game.components.boosts.captive_ball.captive_ball'),
    ball_deceleration = require('src.systems.game.components.boosts.ball_deceleration.ball_deceleration'),
    fireball = require('src.systems.game.components.boosts.fireball.fireball'),

    extend_platform = require('src.systems.game.components.boosts.extend_platform.extend_platform'),
    platform_acceleration = require('src.systems.game.components.boosts.platform_acceleration.platform_acceleration'),
    platform_deceleration = require('src.systems.game.components.boosts.platform_deceleration.platform_deceleration'),
    shorten_platform = require('src.systems.game.components.boosts.shorten_platform.shorten_platform'),

    bonus_life = require('src.systems.game.components.boosts.bonus_life.bonus_life'),
    black_label = require('src.systems.game.components.boosts.black_label.black_label'),

    simple_bomb = require('src.systems.game.components.boosts.simple_bomb.simple_bomb'),
    color_bomb = require('src.systems.game.components.boosts.color_bomb.color_bomb'),
    horizontal_bomb = require('src.systems.game.components.boosts.horizontal_bomb.horizontal_bomb'),
    vertical_bomb = require('src.systems.game.components.boosts.vertical_bomb.vertical_bomb'),

    empty = require('src.systems.game.components.boosts.empty.empty')
}

return Boosts
