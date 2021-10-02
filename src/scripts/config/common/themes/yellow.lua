local YellowTheme = {}

YellowTheme.common_pallettes = {
    disabled = {
        text = 'FFFFFF',
        graphics = 'CACACA',
    },
}

YellowTheme.rating_help_popup = {
    root = {
        bg = 'FBFAFF',
        title = '464646',
        steps_texts = '555555',
        steps_icons_bg = 'EDEDED',
        header_buttons = '818181',
        arrows = '58595B',
    },

    button_rating = {
        title = 'FFFFFF',
        bg = '8B47CE',
    },

    button_ok = {
        title = 'FFFFFF',
        bg = 'A660EC',
    },

    pedestal = {
        titles = 'FFFFFF',
        first_place = '767C83',
        second_place = '59626C',
        third_place = '505A64',
    },

    get_points = {
        icon = '4E5660',
    },
}

YellowTheme.rating_popup = {
    root = {
        bg = 'FBFAFF',
        title = '464646',
        header_buttons = '818181',
        scroll_divider = 'EDEDED',
        loading_text = '555555',
    },

    scroll_item_first_place = {
        bg = 'EDEDED',
        user_icon_stroke = 'FFD600',
        rank_text = 'A07401',
        username = '555555',
        points_text = '555555',
    },

    scroll_item_second_place = {
        bg = 'EDEDED',
        user_icon_stroke = 'B2BED7',
        rank_text = '5C6983',
        username = '555555',
        points_text = '555555',
    },

    scroll_item_third_place = {
        bg = 'EDEDED',
        user_icon_stroke = 'E09870',
        rank_text = '7F492B',
        username = '555555',
        points_text = '555555',
    },

    scroll_item_current_user = {
        bg = 'FFE492',
        user_icon_stroke = 'A660EC',
        rank_text = 'FFFFFF',
        username = '8B47CE',
        points_text = '8B47CE',
    },

    scroll_item_standard_user = {
        bg = 'EDEDED',
        user_icon_stroke = 'C0BBC6',
        rank_text = '4F4D52',
        username = '555555',
        points_text = '555555',
    },

    scrollbar = {
        container = 'CFCFCF',
        inner = '929497',
    },

}

YellowTheme.common = {
    background = 'FBFAFF',
    version_label = 'FBFAFF',

    keyboard = {
        keys = 'FBFAFF',
        selected = 'A660EC',
        bg = 'D8D8D8',
    },

    appbar_theme_tool = {
        root = {
            bg = 'FFE492',
        },
        color = {
            selection = 'A660EC',
            color_lock = 'FBFAFF',
        },
    },

    appbar_platform = {
        root = 'F6C938',
        buttons = '464646',
        account_title = '464646',
        special_offer_indicator = 'A660EC',
    },

    appbar_with_rank = {
        root = {
            bg = 'F6C938',
            buttons = '464646',
            rank_title = '464646',
            rank_percentage = '464646',
            rank_icon = '464646',
            rank_icon_bg = 'FFFFFF',
            special_offer_indicator = 'A660EC',
        },

        star = {
            fill = 'FFFFFF',
            stroke = 'FFFFFF',
        },
    },

    appbar_simple = {
        container = 'F6C938',
        button = '464646',
        title = '464646',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '464646',
        },
    },

    rank_widget = {
        texts = {
            rank_title = '292929',
            pfx = '8B47CE',
            percentage = '292929',
        },

        icon = {
            primary = {
                main = 'FFFFFF',
                bg = 'EDEDED',
            },
            locked = {
                main = '818181',
                bg = 'EDEDED',
            },
        },

        progressbar = {
            filled = 'FFFFFF',
            blank = 'FFE492',
        },

        progressbar_star = {
            fill = 'FFFFFF',
            stroke = 'F6C938',
        },

        rank_star = {
            fill = 'FFFFFF',
            stroke = 'FFFFFF',
        },
    },

    checkbox = {
        icon = '464646',
        stroke = 'FFAE20',
        text = '464646',
    },

    simple_popup = {
        root = 'FBFAFF',
        title = '292929',
        text = '464646',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = 'A660EC',
    },

    game_area = {
        cell_note_text = {
            text = '242424',
        },

        grid = {
            stroke = 'F6C938',
            lines = 'A3A3A3',
            region_lines = 'F6C938',
            wrapper = 'FBFAFF',
        },

        draggable_number = {
            text = '242424',
        },

        grid_number = {
            primary = {
                number = '242424',
            },
            inserted = {
                number = 'A660EC',
            },
            error = {
                number = 'FC1313',
            },
        },

        nums_panel = {
            wrapper = 'FBFAFF',
        },

        grid_cell = {
            primary = {
                base = {
                    bg = 'FFFFFF',
                    pfx = '8B47CE',
                },
                selection = {
                    bg = 'FFEC8B',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'FFD18C',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'FFE492',
                },
                transitions = {{
                    bg = 'FFE492',
                }, {
                    bg = 'FFE9A6',
                }, {
                    bg = 'FFF0C3',
                }, {
                    bg = 'FFF6DA',
                }, {
                    bg = 'FFFFFF',
                }},
            },
            error = {
                base = {
                    bg = 'FFFFFF',
                },
                selection = {
                    bg = 'FFEC8B',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'FFD18C',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'FFE492',
                },
                transitions = {{
                    bg = 'FFE492',
                }, {
                    bg = 'FFE9A6',
                }, {
                    bg = 'FFF0C3',
                }, {
                    bg = 'FFF6DA',
                }, {
                    bg = 'FFFFFF',
                }},
            },
        },

        nums_panel_number = {
            primary = {
                base = {
                    text = '464646',
                    bg = 'FFFFFF',
                },
                selection = {
                    text = '464646',
                    bg = 'FFE492',
                },
            },
            notes = {
                base = {
                    text = 'A660EC',
                    bg = 'FFD963',
                },
                selection = {
                    text = 'A660EC',
                    bg = 'FFE79E',
                },
            },
        },

        tool_button = {
            primary = {
                text = '292929',
                icon = '292929',
            },
            click = {
                text = 'A660EC',
                icon = 'A660EC',
            },
        },

        hint_count = {
            free = {
                text = 'FFFFFF',
                bg = 'F58817',
            },
        },

        hint_count_rewarded_icon = {
            bg = 'A660EC',
        },

        hint_count_rewarded_timer = {
            text = '292929',
            bg = 'F6C938',
        },
    },
}

YellowTheme.settings_screen = {
    root = {
        bg = 'FFFFFF',
        settings_container = 'EDEDED',
        version_label = '464646',
        setting_titles = '464646',
    },

    switch = {
        enabled = {
            container = 'F6C938',
            icon = 'A660EC',
        },
        disabled = {
            container = 'CACACA',
            icon = '818181',
        },
    },

    radio_button = {
        enabled = {
            container = 'F6C938',
            icon = 'A660EC',
            title = '555555',
        },
        disabled = {
            container = 'CACACA',
            icon = '818181',
            title = '555555',
        },
    },

    button_save_progress = {
        container = 'F6C938',
        icon = 'FBFAFF',
        text = '464646',
    },

    platform_logo = {
        yandex = {
            icon = 'E02226',
            bg = 'FBFAFF',
        },
    },

    auth_status = {
        primary = {
            icon = 'A660EC',
            text = '464646',
        },
        warning = {
            icon = 'FF8811',
            text = '464646',
        },
    },
}

YellowTheme.game_screen = {
    root = {
        difficulty_label = '818181',
        errors_label = '818181',
        bg = 'FFFFFF',
    },

    timer = {
        timer_label = '464646',
        pause_button = '464646',
        container = 'EDEDED',
    },
}

YellowTheme.start_screen = {
    root = {
        bg = 'F6C938',
        arrows = '464646',
    },

    platform_logo = {
        yandex = {
            icon = 'E02226',
            bg = 'FBFAFF',
        },
    },

    button_continue_game = {
        primary = {
            title = 'FFFFFF',
            bg = '8B47CE',
        },
        disabled = {
            title = 'FFFFFF',
            bg = 'CACACA',
        },
    },

    button_new_game = {
        title = 'FFFFFF',
        last_game_text = 'FFFFFF',
        bg = 'A660EC',
    },

    secondary_buttons = {
        primary = {
            title = '292929',
            icon = 'A660EC',
            icon_bg = 'FBFAFF',
        },
        disabled = {
            title = '292929',
            icon = 'CACACA',
            icon_bg = 'FFFFFF',
        },
    },
}

YellowTheme.difficulty_popup = {
    root = {
        bg = 'FBFAFF',
        title = '292929',
        button_close = '818181',
    },

    item = {
        primary = {
            title = '464646',
            bg = 'FBFAFF22',
            points_text = '464646',
            points_icon = '464646',
            icon_inaccessible = '464646',
        },
        selection = {
            title = '464646',
            bg = '69696922',
        },

        icon = {
            filled = '464646',
            blank = 'CACACA',
        },
        master_icon = {
            icon = '464646',
        },
    },
    tooltip = {
        bg = 'FFCD32',
        text = '464646',
    },
    warning = {
        icon_bg = 'A660EC',
        icon_text = 'FFFFFF',
        text = '292929',
    },
}

YellowTheme.stats_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '292929',
    },

    difficulty_stat_item = {
        main = '464646',
        icon = '464646',
        title = '464646',
        value = '464646',
    },

    common_section = {
        container = 'EDEDED',
        title = '464646',
        value = '464646',
    },

    difficulty_section = {
        container = 'EDEDED',
        title = '464646',
    },

    arrows = {
        stroke = 'CACACA',
        icon = '464646',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '464646',
        },
    },
}

YellowTheme.defeat_popup = {
    root = {
        title = '292929',
        icon_bg = 'EDEDED',
        bg = 'FBFAFF',
    },

    button_undo_error = {
        bg = 'A660EC',
        title = 'FFFFFF',
        icon = 'FFFFFF',
    },

    buttons_flat = {
        title = '292929',
    },
}

YellowTheme.victory_screen = {
    root = {
        praise = '292929',
        bg = 'F6C938',
    },

    button_home = {
        title = 'FFFFFF',
        bg = 'A660EC',
    },

    button_new_game = {
        title = 'FFFFFF',
        bg = '8B47CE',
    },

    level_spec = {
        title = '292929',
        value = '292929',
        icon = '292929',
        icon_difficulty_part = 'FFFFFF',
    },
}

YellowTheme.pause_popup = {
    root = {
        title = '292929',
        bg = 'FBFAFF',
        button_close = '818181',
    },

    specs = {
        container = 'EDEDED',
        titles = '464646',
        values = '464646',
    },

    button_continue = {
        title = 'FFFFFF',
        bg = 'A660EC',
    },

    fact = {
        icon = '464646',
        title = '464646',
        text = '464646',
    },
}

YellowTheme.store_screen = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
    },

    pack_header = {
        bg = 'A660EC',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = 'F6C938',
        text = '464646',
    },

    button_buy_special = {
        bg = 'F6C938',
        text = '464646',
    },
    button_buy_special_timer = {
        container = 'A660EC',
        icon = 'FFFFFF',
        text = 'FFFFFF',
    },

    button_buy_special_old_cost = {
        text = '464646',
        line = 'FF8811',
    },

    product_with_title = {
        text = '464646',
    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = '464646',
    },

    product_simple = {
        text = '464646',
        icon = '464646',
    },
}

YellowTheme.post_purchase_popup = {
    root = {
        bg = 'FBFAFF',
        title = '292929',
        text = '464646',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = 'A660EC',
        pack_title = '464646',
    },

    pack_item = {
        text = '464646',
        icon = '464646',
    },
}

YellowTheme.reward_rate_game_popup = {
    root = {
        bg = 'FBFAFF',
        title = '292929',
        text = '464646',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = 'A660EC',
    },
}

YellowTheme.rating_unlock_popup = {
    root = {
        bg = 'FBFAFF',
        title = '292929',
        text = '464646',
        text_completed = '464646',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = 'A660EC',
    },
}

YellowTheme.help_screen = {
    root = {
        bg = 'FFFFFF',
        titles = '464646',
        texts = '464646',
        arrow = '464646',
        ranks_section_bg = 'F6C938',
        elems_highlight = 'A660EC',
    },

    arrows = {
        primary = {
            stroke = 'CACACA',
            inner = '464646',
        },
        modified = {
            stroke = '464646',
            inner = '464646',
        },
    },

    rules_section = {
        cells_colors = {
            purple = 'E2CEEC',
            yellow = 'FFEBAD',
            pink = 'F8C6D1',
            center = 'F8C6D1',
        },
    },

    drag_drop_section_draggable = {
        text = 'A660EC',
        bg = 'FBFAFF',
    },

    difficulty_icon = {
        filled = '464646',
        blank = 'FFFFFF',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '464646',
        },
        primary_modified = {
            bg = 'FFFFFF',
        },
        active_modified = {
            bg = '464646',
        },
    },
}

YellowTheme.starter_pack_offer_popup = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
        title = '292929',
        button_close = '818181',
    },

    pack_header = {
        bg = 'A660EC',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = 'A660EC',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = 'A660EC',
        text = 'FFFFFF',
    },
    button_buy_special_timer = {
        container = 'FF8811',
        icon = 'FFFFFF',
        text = 'FFFFFF',
    },

    button_buy_special_old_cost = {
        text = 'FFFFFF',
        line = 'FF8811',
    },

    product_with_title = {
        text = '464646',
    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = '464646',
    },

    product_simple = {
        text = '464646',
        icon = '464646',
    },
}

return YellowTheme
