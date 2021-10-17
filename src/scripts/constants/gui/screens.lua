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

    energy_widget = {
        container = 'appbar/energy/container',
        icon = 'appbar/energy/icon',
        text = 'appbar/energy/text',
    },

    button_pause = {
        container = 'appbar/pause/container',
        icon = 'appbar/pause/icon',
        text = 'appbar/pause/text',
    },

    lives_widget = {
        container = 'appbar/lives/container',
        template = 'appbar/lives/template',
    },

    balls_factory = '/go#balls_factory',
    block_factory = '/go#block_factory',
    boost_factory = '/go#boost_factory',
}

return ScreensConstants
