local CommonUIConfig = {
    leaderboards = {
        max_user_name_length = 20,
        max_user_name_lines = 2,
    },

    components = {
        progress = {
            animations_delay = 0.2,
            rank_stars_gap = 22,
            progressbar_animated = {
                scale = 0.86,
                scale_master = 1,
            },
            progressbar_stroke = {
                width = 20.5,
            },
        },
        appbar_with_rank = {
            rank_stars_gap = 8,
            title_percent_gap = 3,
            rank_icon_and_titles_gap = 15,
        },
        appbar_platform = {
            account_info_gap = 9,
            user_icon_sizes = {
                x = 58,
                y = 58,
            },
            default_user_icon = 'default_user_icon_appbar',
        },
        appbar_theme_tool = {
            colors_gaps = {
                x = 14,
                y = 20,
            },
            container_paddings = {
                x = 20,
                y = 20,
            },
            dimensions = {
                x = 2,
                y = 0,
            },
            delay_before_starter_pack_offer = 1,
        },
        checkbox = {
            gap = 16,
        },
    },

    templates = {
        simple_popup = {
            gaps = {35, 30, 30, 30, 25},
            gaps_without_icon = {35, 40, 53, 25},
            gaps_with_checkbox = {35, 30, 22, 16, 29, 26},
        },
    },

    fonts = {
        RobotoFamily = 'Roboto',
        RobotoRegular = 'RobotoRegular32',
        RobotoMedium = 'RobotoMedium26',
        RobotoBold = 'RobotoBold38',
    },
}

return CommonUIConfig
