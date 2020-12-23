local ScenesUrls = {
    game_scene = {
        main = 'game_scene',
        scene = 'game_scene:/scene',
        factory = '/scene#factory',
        ball = '/ball',
        platform = '/platform',
        losing_zone = '/losing_zone',
        walls = {
            wall_left = '/wall_left',
            wall_top = '/wall_top',
            wall_right = '/wall_right',
            wall_bottom = '/wall_bottom'
        },
        gui = '/scene#gui'
    },
    game_victory_scene = {
        main = 'game_victory_scene'
    },
    pack_selection_scene = {
        main = 'pack_selection_scene'
    },
    start_scene = {
        main = 'start_scene'
    },
    game_pause_popup = {
        main = 'game_pause_popup'
    },
    game_losing_popup = {
        main = 'game_losing_popup'
    }
}

return ScenesUrls
