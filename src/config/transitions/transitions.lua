local ScenesTransitions = require('src.libs.scenes_transitions.scenes_transitions')
local TRANS = ScenesTransitions.TRANSITIONS_CONST

local TransitionsConfig = {
    game_pause_popup = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.7,
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
            easing = gui.EASING_LINEAR,
            duration = 0.3,
            delay = 0
        },
        trans_in = TRANS.fade_out,
        trans_out = TRANS.fade_in
    },
    game_victory_scene = {
        popup = {
            config = {
                easing = gui.EASING_INQUAD,
                duration = 0.5,
                delay = 0
            },
            trans_in = TRANS.slide_in_top,
            trans_out = TRANS.slide_out_top
        },
        fade = {
            config = {
                easing = gui.EASING_INOUTCIRC,
                duration = 0.3,
                delay = 0
            },
            trans_in = TRANS.fade_out,
            trans_out = TRANS.fade_in
        }
    },
    pack_selection_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.3,
            delay = 0
        },
        trans_in = TRANS.slide_in_top,
        trans_out = TRANS.slide_out_top
    },
    start_scene = {
        config = {
            easing = gui.EASING_INQUAD,
            duration = 0.3,
            delay = 0
        },
        trans_in = TRANS.fade_out,
        trans_out = TRANS.fade_in
    }
}

return TransitionsConfig
