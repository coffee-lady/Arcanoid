local Boosts = {
    ['1'] = require('src.scripts.scenes.game_scene.view.boosts.ball.ball_acceleration'),
    ['2'] = require('src.scripts.scenes.game_scene.view.boosts.ball.ball_deceleration'),
    ['3'] = require('src.scripts.scenes.game_scene.view.boosts.ball.captive_ball'),
    ['4'] = require('src.scripts.scenes.game_scene.view.boosts.ball.fireball'),

    ['5'] = require('src.scripts.scenes.game_scene.view.boosts.bombs.simple_bomb'),
    ['6'] = require('src.scripts.scenes.game_scene.view.boosts.bombs.color_bomb'),
    ['7'] = require('src.scripts.scenes.game_scene.view.boosts.bombs.horizontal_bomb'),
    ['8'] = require('src.scripts.scenes.game_scene.view.boosts.bombs.vertical_bomb'),

    ['9'] = require('src.scripts.scenes.game_scene.view.boosts.life.black_label'),
    ['10'] = require('src.scripts.scenes.game_scene.view.boosts.life.bonus_life'),

    ['11'] = require('src.scripts.scenes.game_scene.view.boosts.platform.extend_platform'),
    ['12'] = require('src.scripts.scenes.game_scene.view.boosts.platform.platform_acceleration'),
    ['13'] = require('src.scripts.scenes.game_scene.view.boosts.platform.platform_deceleration'),
    ['14'] = require('src.scripts.scenes.game_scene.view.boosts.platform.shorten_platform'),
}

return Boosts
