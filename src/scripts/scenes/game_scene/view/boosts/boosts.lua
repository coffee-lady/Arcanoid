local Boosts = {
    ['1'] = require('src.systems.game.components.boosts.ball_acceleration.ball_acceleration'),
    ['2'] = require('src.systems.game.components.boosts.ball_deceleration.ball_deceleration'),
    ['3'] = require('src.systems.game.components.boosts.captive_ball.captive_ball'),
    ['4'] = require('src.systems.game.components.boosts.fireball.fireball'),

    ['5'] = require('src.systems.game.components.boosts.simple_bomb.simple_bomb'),
    ['6'] = require('src.systems.game.components.boosts.color_bomb.color_bomb'),
    ['7'] = require('src.systems.game.components.boosts.horizontal_bomb.horizontal_bomb'),
    ['8'] = require('src.systems.game.components.boosts.vertical_bomb.vertical_bomb'),

    ['9'] = require('src.systems.game.components.boosts.black_label.black_label'),
    ['10'] = require('src.systems.game.components.boosts.bonus_life.bonus_life'),

    ['11'] = require('src.systems.game.components.boosts.extend_platform.extend_platform'),
    ['12'] = require('src.systems.game.components.boosts.platform_acceleration.platform_acceleration'),
    ['13'] = require('src.systems.game.components.boosts.platform_deceleration.platform_deceleration'),
    ['14'] = require('src.systems.game.components.boosts.shorten_platform.shorten_platform')
}

return Boosts
