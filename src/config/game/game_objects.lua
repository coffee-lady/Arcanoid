local GameGOConfig = {
    blocks = {
        top_padding = 0.13,
        sides_padding = 0.3,
        indent_between = 0.2,
        sprite_falling_duration = 1,
        leftover_lives_for_cracks = 1,
        destroy_granite = false
    },

    ball = {
        speed = {
            min = vmath.vector3(350, 350, 0),
            start = vmath.vector3(380, 380, 0),
            max = vmath.vector3(480, 480, 0)
        },

        delta_speed = vmath.vector3(8, 8, 0),
        scale = 0.4,
        start_rel_pos = vmath.vector3(0.5, 0.2, 0),
        rotation_angle = 360,
        rotation_duration = 2
    },

    platform = {
        bottom_padding = 0.1,
        scale = {
            min = 0.4,
            start = 0.45,
            max = 0.6
        },
        min_dx = 10,
        moving_duration = {
            min = 0.03,
            start = 0.05,
            max = 1
        },
        scaling_duration = 0.07
    },

    walls = {
        wall_left = {
            pos = vmath.vector3(0, 0.5, 0)
        },
        wall_top = {
            pos = vmath.vector3(0.5, 0.87, 0)
        },
        wall_right = {
            pos = vmath.vector3(1, 0.5, 0)
        }
    },

    losing_zone = {
        bottom_padding = 0
    },

    energy = {
        max_count = 30,
        recovery_time = 1200,
        recovery_count = 1,
        level_cost = 3,
        restart_cost = 3,
        life_cost = 6,
        level_reward = 2
    },

    lives = {
        indent_between = 0.01,
        animation = 'heart',
        count = 3
    },

    start_level = 1
}

return GameGOConfig
