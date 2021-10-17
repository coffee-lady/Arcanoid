local GameConfig = {}

GameConfig.energy = {
    recovery_time = 1200,
    recovery_count = 5,
    max_count = 32,
    level_reward = 1,
    game_cost = 2,
    life_cost = 2,
    restart_cost = 2,
}

GameConfig.balls = {
    rel_size = 0.05,
    min_scale = 0.3,

    speed = {
        start = vmath.vector3(400, 400, 0),
        min = vmath.vector3(350, 350, 0),
        max = vmath.vector3(480, 480, 0),
        delta_speed = vmath.vector3(5, 5, 0),
    },

    start_rel_pos = vmath.vector3(0.5, 0.2, 0),

    rotation = {
        angle = 360,
        duration = 2,
    },
}

GameConfig.walls = {
    wall_left = {
        rel_pos = vmath.vector3(0, 0.5, 0),
    },
    wall_top = {
        rel_pos = vmath.vector3(0.5, 0.87, 0),
    },
    wall_right = {
        rel_pos = vmath.vector3(1, 0.5, 0),
    },
}

return GameConfig
