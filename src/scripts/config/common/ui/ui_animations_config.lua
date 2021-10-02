local UIAnimationsConfig = {}

UIAnimationsConfig.transitions = {
    init_delay = 1.2,

    screen = {
        duration = 0.5,
        easing = gui.EASING_OUTCIRC,
    },
    popup = {
        animation_in = {
            duration = 0.5,
            duration_bg = 0.8,
            delay_bg = 0,
            easing = gui.EASING_OUTEXPO,
            easing_bg = gui.EASING_OUTEXPO,
        },
        animation_out = {
            duration = 0.35,
            duration_bg = 0.6,
            easing = gui.EASING_INEXPO,
            easing_bg = gui.EASING_INEXPO,
        },
    },
}

UIAnimationsConfig.animations = {
    scroll_horizontal = {
        item_interval = 0.5,
        scroll_offset = 0.5,
        scroll_sensivity = 1.3,
        deceleration_value = 0.5,
        duration_select = 0.9,
        is_horizontal = true,
        snap_duration = 0.9,
    },

    scroll_vertical = {
        item_interval = 0.5,
        scroll_offset = 0.5,
        scroll_sensivity = 2,
        deceleration_value = 0.5,
        duration_select = 0.9,
        is_horizontal = false,
        snap_duration = 0.9,
    },

    scrollbar_vertical = {
        is_vertical = true,
        sensivity = 1.3,
    },

    progress = {
        icon_animation_delay = 0.7,

        progressbar = {
            duration_for_perc = 0.035,
            min_duration = 0.5,
            max_duration = 1.5,
            star_fade_duration = 0.3,
            duration_circle = 0.7,
        },

        percentage = {
            scale_to = 0.7,
        },

        partial = {
            rank_icon = {
                scale_to = 1.3,
                duration = 0.3,
            },
        },

        rank_title = {
            scale_disappear = 0,
            scale_increase = 0.7,
            duration_disappear = 0.2,
            duration_increase = 0.2,
            duration_decrease = 0.2,
        },

        rank_icon = {
            scale_disappear = 0,
            scale_increase = 1.3,
            scale_decrease = 0.7,
            duration_disappear = 0.2,
            duration_increase = 0.2,
            duration_decrease = 0.2,
        },

        progressbar_rank_star = {
            duration_move = 0.5,
            easing_move = gui.EASING_INSINE,
            path_ctrl_random = {100, 200},
            duration_fadein = 0.3,
            duration_fadeout = 0.3,
            points = 25,
        },

        rank_star = {
            straight = {
                duration = 0.1,
                scale_to = {{
                    stroke = 0.4,
                }, {
                    fill = 0.7,
                }, {
                    fill = 1.3,
                }, {
                    stroke = 1.2,
                }, {
                    stroke = 0.85,
                    fill = 1,
                }, {
                    stroke = 1,
                    fill = 1,
                }},
            },
            back = {
                duration = 0.1,
                scale_to = {{
                    stroke = 0.85,
                    fill = 1,
                }, {
                    stroke = 0.4,
                }, {
                    fill = 0.7,
                }, {
                    stroke = 1,
                }},
            },
        },
    },

    game_screen = {
        grid_cell = {
            wave = {
                duration = 0.1,
                duration_transitions = 0.4,
            },
        },

        hint = {
            points = 25,
            duration = 0.4,
            easing = gui.EASING_INQUINT,
            delay = 0.1,
        },
    },

    game_area = {
        drag_and_drop_draggable = {
            points_count = 30,
            duration = 0.8,
            easing = gui.EASING_INCIRC,
        },
    },

    difficulty_popup = {
        tooltip = {
            duration = 0.2,
            enabled_duration = 3,
        },
        selection_duration = 0.4,
    },

    victory_screen = {
        points = {
            scale_increase = 1,
            scale_decrease = 0.88,
            duration_increase = 0.1,
            duration_decrease = 0.1,
        },
    },
}

return UIAnimationsConfig
