local ScreensConstants = {
    bootstrap = {
        container = 'container',
    },
}

ScreensConstants.start_scene = {
    root = 'root',
    background = 'background',

    button_settings = {
        container = 'appbar/button_settings/container',
        icon = 'appbar/button_settings/icon',
        text = 'appbar/button_settings/text',
    },

    button_store = {
        container = 'appbar/button_store/container',
        icon = 'appbar/button_store/icon',
        text = 'appbar/button_store/text',
    },

    button_play = {
        container = 'button_play/container',
        inner = 'button_play/inner',
        text = 'button_play/text',
    },
}

ScreensConstants.game_scene = {
    root = 'root',
    background = 'background',

    energy = {
        container = 'appbar/energy/container',
        icon = 'appbar/energy/icon',
        text = 'appbar/energy/text',
    },

    pause = {
        container = 'appbar/pause/container',
        icon = 'appbar/pause/icon',
        text = 'appbar/pause/text',
    },

    lives = {
        container = 'appbar/lives/container',
        template = 'appbar/lives/template',
    },

    ball_factory = 'ball_factory',
    block_factory = 'block_factory',
    boost_factory = 'boost_factory',
}

return ScreensConstants
