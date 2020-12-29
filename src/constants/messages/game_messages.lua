local GameMessages = {
    lost_ball = hash('lost_ball'),
    add_balls = hash('add_balls'),
    reset_ball = hash('reset_ball'),
    accelerate_ball = hash('accelerate_ball'),
    decelerate_ball = hash('decelerate_ball'),
    delete_ball = hash('delete_ball'),
    fire_balls = hash('fire_balls'),
    put_out_balls = hash('put_out_balls'),

    increase_lives = hash('increase_lives'),
    decrease_lives = hash('decrease_lives'),

    block_destructed = hash('block_destructed'),
    blocks_deleted = hash('blocks_deleted'),
    damage_block = hash('damage_block'),
    destroy_block = hash('destroy_block'),

    pause = hash('pause'),
    continue = hash('continue'),
    restart = hash('restart'),
    winning = hash('winning'),
    losing = hash('losing'),

    bomb_activated = hash('bomb_activated'),
    bomb_deactivated = hash('bomb_deactivated'),

    boost_collision = hash('boost_collision'),

    shorten_platform = hash('shorten_platform'),
    extend_platform = hash('extend_platform'),
    accelerate_platform = hash('accelerate_platform'),
    decelerate_platform = hash('decelerate_platform')
}

return GameMessages
