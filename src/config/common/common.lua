local CommonConfig = {
    gui = {
        button = {
            blackout = 0.1,
            scale = vmath.vector3(0.9, 0.9, 0),
            duration = 0.08,
            easing = gui.EASING_LINEAR
        },
        scroll = {
            duration = 0.02
        }
    },

    animations = {
        game_victory_scene = {
            pack_icon = {
                easing = gui.EASING_INEXPO,
                duration = 0.5,
                delay = 0.8
            },
            energy = {
                duration = 0.5,
                delay = 0
            },
            level = {
                delay = 0.6
            }
        }
    }
}

return CommonConfig
