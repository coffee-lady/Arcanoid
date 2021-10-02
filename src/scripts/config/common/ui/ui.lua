local AnimationsConfig = require('src.scripts.config.common.ui.ui_animations_config')
local CommonUIConfig = require('src.scripts.config.common.ui.ui_common_config')
local PlatformUIConfig = require('src.scripts.config.common.ui.ui_platform_config')

local UIConfig = {}

UIConfig.transitions = AnimationsConfig.transitions
UIConfig.animations = AnimationsConfig.animations
UIConfig.common = CommonUIConfig
UIConfig.platform = PlatformUIConfig

UIConfig.rating_help_popup_delay = 1
UIConfig.feedback_popup_delay = 3

UIConfig.game_screen = {
    victory_screen_delay = 0.5,
    defeat_popup_delay = 0.5,

    banner_place = {
        height = 145,
        widht = 640,
    },

    grid = {
        cells_gap = 1,
        cells_gap_big = 3,
        big_padding_interval = 3,
    },
    cell = {
        number_modes = {
            inserted = 'inserted',
        },
        highlight_modes = {
            error_reason = 'error_reason',
            similar_num = 'similar_num',
            similar_region = 'similar_region',
            similar_line = 'similar_line',
        },
    },
    notes = {
        gap = 7,
        fonts = {
            base = 'RobotoRegular32',
            base_scale = 21 / 32,
            selection = 'RobotoMedium26',
            selection_scale = 21 / 26,
        },
    },
    nums_panel = {
        padding = 0,
        gap = 0,
        animations = {
            click = {
                property = 'color',
                duration = 0.3,
                easing = gui.EASING_OUTQUART,
                delay = 0,
                playback = gui.PLAYBACK_ONCE_PINGPONG,
            },
        },
        modes = {
            notes = 'notes',
        },
    },
    tools = {
        gap = 50,
        animations = {
            click = {
                property = 'color',
                duration = 0.3,
                easing = gui.EASING_OUTQUART,
                delay = 0,
                playback = gui.PLAYBACK_ONCE_PINGPONG,
            },
        },
        hint_count_mods = {
            free = 'free',
            paid = 'paid',
            rewarded = 'rewarded',
            rewarded_timer = 'rewarded_timer',
        },
        hint_count_gaps = {7, 7},
    },
}

UIConfig.start_screen = {
    main_buttons_gap = 20,
    continue_button_subtext = {
        gap = 6,
    },
    rank_texts_pos_y = {
        standard = -109,
        master = -110,
        locked = -120,
    },
}

UIConfig.pause_popup = {
    specs_gap = 20,
    gaps = {35, 30, 30, 39, 38, 25},
}

UIConfig.mastery_popup = {
    gaps = {35, 30, 30, 30, 30, 25},
}

UIConfig.difficulty_popup = {
    difficulty = {
        icons_pieces_count = 9,
        icons_pieces_count_row = 3,
        filled_count = {
            veryeasy = 1,
            easy = 2,
            medium = 3,
            hard = 4,
            expert = 5,
            master = 6,
        },
    },
}

UIConfig.defeat_popup = {
    button_undo_error = {
        gap = 21,
        icon_rewarded = 'defeat_popup_undo_error_reward',
        icon_paid = 'btn_paid_cancel_error_icon',
    },
}

UIConfig.victory_screen = {
    clicks_delay = 3,
    praise_text_on_series_count = 5,
    rank_icon_scale = {
        master = 1,
    },
    rank_texts_pos_y = {
        master = -144,
    },
    points_counter_duration = 2,
}

UIConfig.stats_screen = {
    scroll_indicators = {
        gap = 20,
    },
}

UIConfig.post_purchase_popup = {
    text_parts_gap = 6,
    product_item_gap = 5,
    products_icons = {
        hints = 'store_product_hint',
        canceling_errors = 'store_product_error_undo',
    },
}

UIConfig.starter_pack_offer_popup = {
    items_icons = {
        hints = 'store_product_hint',
        no_ads = 'store_product_no_ads',
        all_themes = 'store_product_theme',
        canceling_errors = 'store_product_error_undo',
    },
    simple_product_item_gap = 15,
    titled_product_item_gap = 15,
    special_button_timer_gaps = {8, 8, 8},

    packs_container_gaps = {
        x = 10,
        y = 10,
    },

    items_gaps = {
        grid = {
            x = 30,
            y = 25,
        },
    },

    packs_config = {
        sdi_ya_starter_pack = {
            type = 'big',
            items_layout = 'grid',
            header = 'straight',
            items_order = {
                no_ads = 1,
                canceling_errors = 2,
                all_themes = 3,
                hints = 4,
            },
        },
    },

    gaps = {35, 30, 30, 25},
}

UIConfig.help_screen = {
    grid_string = '008000000490157002003004190185060020000020060960405300030072004041030057827009013',
    grid_string_full = '123456789456789132789123465567891243234567819591234576912345687678912354345678921',
    grid_size = 9,

    rules_section = {
        cells_colors = {
            purple = {55, 56, 57, 64, 65, 66, 73, 74, 75},
            pink = {6, 15, 24, 42, 51, 60, 69, 78},
            yellow = {28, 29, 30, 31, 32, 34, 35, 36},
            center = {33},
        },
    },

    filling_cells_section = {
        selected_cell_index = 58,
        selected_nums_panel_item = 2,
        game_area_params = {
            disable_grid_fit = true,
            disable_hint_count = true,
        },
    },

    notes_section = {
        selected_cell_index = 58,
        notes_in_cell = {2, 4, 6},
        game_area_params = {
            disable_grid_fit = true,
            disable_hint_count = true,
        },
    },

    ranks_section = {
        items_gap = 67,
        item_difficulty_gaps = {0, 10, 10, 7, 0},
        items = {{
            rank_index = 1,
            is_master = false,
            stars_count = 0,
            rank_percentage = 20,
            difficulty_index = 1,
            difficulty_id = 'easy',
        }, {
            rank_index = 1,
            is_master = false,
            stars_count = 2,
            rank_percentage = 70,
            difficulty_index = 3,
            difficulty_id = 'hard',
        }},
    },

    keyboard_input_first_section = {
        selected_cell_index = 58,
        selected_nums_panel_item = 5,
        game_area_params = {
            disable_grid_fit = true,
            disable_hint_count = true,
        },
    },

    keyboard_input_second_section = {
        selected_cell_index = 76,
        selected_nums_panel_item = 5,
        game_area_params = {
            disable_grid_fit = true,
            disable_hint_count = true,
        },
    },

    drag_and_drop_section = {
        selected_cell_index = 58,
        selected_nums_panel_item = 5,
        game_area_params = {
            disable_grid_fit = true,
            disable_hint_count = true,
        },
    },
}

UIConfig.settings_screen = {
    user_icon_sizes = {
        x = 74,
        y = 74,
    },

    auth_status_icon = {
        warning = 'settings_screen_auth_warning',
        ok = 'settings_screen_auth_ok',
    },

    default_user_icon = 'default_user_icon',
}

UIConfig.store_screen = {
    packs_titles = {
        starter_pack_title = {1},
        best_offer_title = {3},
        hit_title = {5},
        best_title = {7},
    },
    items_icons = {
        hints = 'store_product_hint',
        no_ads = 'store_product_no_ads',
        all_themes = 'store_product_theme',
        canceling_errors = 'store_product_error_undo',
    },
    simple_product_item_gap = 13,
    titled_product_item_gap = 13,
    special_button_timer_gaps = {7, 5, 7},

    packs_container_gaps = {
        x = 10,
        y = 10,
    },

    items_gaps = {
        grid = {
            x = 20,
            y = 25,
        },
        vertical = 25,
    },

    packs_types = {
        big = {
            header_pos = vmath.vector3(0, 151, 0),
            main_layout_gaps = {89, 38, 13},
            container_sizes = vmath.vector3(376, 340, 0),
            button_width = 230,
        },
        small = {
            header_pos = vmath.vector3(-44, 121, 0),
            main_layout_gaps = {89, 38, 13},
            container_sizes = vmath.vector3(184, 340, 0),
            button_width = 164,
        },
    },

    packs_order = {
        [1] = 1,
        [3] = 1,
        [4] = 3,
        [5] = 4,
        [6] = 5,
        [7] = 6,
    },

    packs_config = {
        [1] = {
            type = 'big',
            items_layout = 'grid',
            header = 'straight',
            items_order = {
                no_ads = 1,
                canceling_errors = 2,
                all_themes = 3,
                hints = 4,
            },
        },
        [3] = {
            type = 'big',
            items_layout = 'vertical',
            header = 'straight',
            items_order = {
                canceling_errors = 1,
                hints = 2,
            },
        },
        [4] = {
            type = 'small',
            items_layout = 'vertical',
            items_order = {
                canceling_errors = 1,
                hints = 2,
            },
        },
        [5] = {
            type = 'small',
            items_layout = 'vertical',
            header = 'oblique',
            items_order = {
                canceling_errors = 1,
                hints = 2,
            },
        },
        [6] = {
            type = 'small',
            items_layout = 'vertical',
            items_order = {
                canceling_errors = 1,
                hints = 2,
            },
        },
        [7] = {
            type = 'small',
            items_layout = 'vertical',
            header = 'oblique',
            items_order = {
                canceling_errors = 1,
                hints = 2,
            },
        },
    },
}

UIConfig.rating_popup = {
    scroll = {
        item_interval = 0.15,
        scroll_offset = 0.12,
        scroll_sensivity = 3.5,
        deceleration_value = 0.5,
        duration_select = 0.4,
        is_horizontal = false,
        snap_duration = 0.9,
    },
    scroll_min_y = -273,
    scroll_max_y = 260,
    user_icon_size = vmath.vector3(57, 57, 0),
    user_rank_paddings = {12, 12},
}

UIConfig.reward_rate_game_popup = {
    reward_gap = 5,
    rewarding_text_parts_gap = 6,
    texts_vertical_gap = 12,
    gaps = {35, 30, 30, 30, 25},
}

return UIConfig
