local BallConfig = {
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
}

return BallConfig
