local ScreensConstants = {
    bootstrap = {
        container = 'container',
    },
}

ScreensConstants.start_screen = {
    root = 'root',
    version = 'version',

    ranks_scroll = 'ranks_scroll',

    arrow_next = {
        container = 'arrow_next/container',
        inner = 'arrow_next/inner',
    },
    arrow_prev = {
        container = 'arrow_prev/container',
        inner = 'arrow_prev/inner',
    },

    fade_left = 'fade_left',
    fade_right = 'fade_right',

    buttons = {
        continue_game = {
            container = 'button_continue_game/container',
            text = 'button_continue_game/text',
            subtext_container = 'button_continue_game/subtext_container',
            subtext_text = 'button_continue_game/subtext_text',
            subtext_icon = 'button_continue_game/subtext_icon',
            inner = 'button_continue_game/inner',
        },

        new_game = {
            container = 'button_new_game/container',
            text = 'button_new_game/text',
            inner = 'button_new_game/inner',

        },

        game_events = {
            container = 'game_events_button/container',
            text = 'game_events_button/title',
            icon = 'game_events_button/icon',
            inner = 'game_events_button/inner',
        },

        rating_button = {
            container = 'rating_button/container',
            text = 'rating_button/title',
            icon = 'rating_button/icon',
            inner = 'rating_button/inner',
        },

        daily_tasks = {
            container = 'daily_tasks_button/container',
            text = 'daily_tasks_button/title',
            icon = 'daily_tasks_button/icon',
            inner = 'daily_tasks_button/inner',
        },
    },
}

return ScreensConstants
