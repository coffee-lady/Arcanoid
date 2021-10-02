local GameConfig = {}

GameConfig.generate_puzzle = false

GameConfig.data_saving_delay = 0.5

GameConfig.ranks = {
    stars = 3,
    points = {260, 520, 1300, 2080, 3380, 4680},
    mastery = {
        start_mastery = 0,
        decrease_points = 10,
        decrease_minutes = 60,
        points = 1000,
        max_points = 1200,
    },
}

GameConfig.puzzle = {
    mixing_cells_iterations = {20, 40},

    cell_modes = {
        number = 1,
        notes = 2,
    },

    grid_size = 9,

    difficulty = {{
        type = 'easy',
        points = 5,
        min = 33,
        max = 36,
    }, {
        type = 'medium',
        points = 15,
        min = 30,
        max = 32,
    }, {
        type = 'hard',
        points = 35,
        min = 26,
        max = 28,
    }, {
        type = 'expert',
        points = 65,
        min = 25,
        max = 28,
    }, {
        type = 'master',
        points = 100,
        min = 25,
        max = 28,
    }},
}

GameConfig.actions_types = {
    InsertNumber = 'InsertNumber',
    RemoveNumber = 'RemoveNumber',
    ClearNumber = 'ClearNumber',
    InsertNote = 'InsertNote',
    RemoveNote = 'RemoveNote',
    ClearNotes = 'ClearNotes',
}

GameConfig.defeat = {
    max_errors = 3,
    lives_for_ad = 1,
}

GameConfig.hints = {
    free = {
        count = 3,
    },
    rewarded = {
        timer = 30,
        animation_delay = 0.5,
    },
}

GameConfig.speed_test = {
    cycles = 50,
    difficulty = 22,
}

return GameConfig
