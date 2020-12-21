local ScenesUrls = {
    game_scene = {
        main = 'game_scene',
        scene = 'game_scene:/scene',
        factory = '/game_scene#factory',
        ball = '/ball',
        platform = '/platform',
        losing_zone = '/losing_zone',
        walls = {
            wall_left = '/wall_left',
            wall_top = '/wall_top',
            wall_right = '/wall_right',
            wall_bottom = '/wall_bottom'
        },
        gui = '/game_scene#gui'
    },
    game_victory_scene = {
        main = 'game_victory_scene'
    },
    pack_selection_scene = {
        main = 'pack_selection_scene'
    },
    start_scene = {
        main = 'start_scene'
    }
}

return ScenesUrls
