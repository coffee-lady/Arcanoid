local ScenesTransitions = require('src.libs.scenes_transitions.scenes_transitions')
local TRANS = ScenesTransitions.TRANSITIONS_CONST

local TransitionsConfig = {
    game_pause_popup = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    game_losing_popup = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    game_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    game_victory_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    pack_select_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    start_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.5,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    }
}

return TransitionsConfig
