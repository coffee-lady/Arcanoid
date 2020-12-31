local BallConfig = {
    speed = {
        min = vmath.vector3(150, 200, 0),
        start = vmath.vector3(500, 400, 0),
        max = vmath.vector3(650, 650, 0)
    },
    delta_speed = vmath.vector3(8, 8, 0),
    scale = 0.4,
    start_rel_pos = vmath.vector3(0.5, 0.2, 0),
    rotation_angle = 360,
    rotation_duration = 2
}

return BallConfig
