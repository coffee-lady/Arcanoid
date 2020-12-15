local ScenesUrls = {
    game_end_scene = {
        main = 'game_end_scene'
    },
    game_scene = {
        main = 'game_scene',
        factory = '/game_scene#factory',
        ball = '/ball',
        platform = '/platform',
        losing_zone = '/losing_zone',
        walls = {
            wall_left = '/wall_left',
            wall_top = '/wall_top',
            wall_right = '/wall_right',
            wall_bottom = '/wall_bottom'
        }
    },
    game_victory_scene = {
        main = 'game_victory_scene'
    },
    pack_select_scene = {
        main = 'pack_select_scene'
    },
    start_scene = {
        main = 'start_scene'
    }
}

return ScenesUrls
