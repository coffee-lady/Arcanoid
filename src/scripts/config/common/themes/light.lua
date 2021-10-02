local LightTheme = {}

LightTheme.common_pallettes = {
    disabled = {
        text = 'FFFFFF',
        graphics = 'CACACA',
    },
}

LightTheme.rating_help_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
        steps_texts = '555555',
        steps_icons_bg = 'EDEDED',
        header_buttons = '818181',
        arrows = '58595B',
    },

    button_rating = {
        title = 'FFFFFF',
        bg = '6462E3',
    },

    button_ok = {
        title = 'FFFFFF',
        bg = '8583FF',
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

LightTheme.rating_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
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
        bg = 'DAE2FF',
        user_icon_stroke = '8583FF',
        rank_text = 'FFFFFF',
        username = '6462E3',
        points_text = '6462E3',
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

LightTheme.common = {
    background = 'FBFAFF',
    version_label = '818181',

    keyboard = {
        keys = 'FBFAFF',
        selected = '8583FF',
        bg = 'D8D8D8',
    },

    appbar_theme_tool = {
        root = {
            bg = 'CACACA',
        },
        color = {
            selection = '8A88FF',
            lock = 'FBFAFF',
        },
    },

    appbar_platform = {
        root = 'EDEDED',
        buttons = '818181',
        account_title = '818181',
        special_offer_indicator = 'FF8811',
    },

    appbar_with_rank = {
        root = {
            bg = 'EDEDED',
            buttons = '818181',
            rank_title = '818181',
            rank_percentage = '818181',
            rank_icon = '818181',
            rank_icon_bg = 'FBFAFF',
            special_offer_indicator = 'FF8811',
        },

        star = {
            fill = 'FF8811',
            stroke = 'FF8811',
        },
    },

    appbar_simple = {
        container = 'EDEDED',
        button = '818181',
        title = '818181',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '818181',
        },
    },

    rank_widget = {
        texts = {
            rank_title = '6462E3',
            pfx = 'FF8811',
            percentage = '6462E3',
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
            filled = 'FFCD32',
            blank = 'EDEDED',
        },

        progressbar_star = {
            fill = 'FF8811',
            stroke = 'FFFFFF',
        },

        rank_star = {
            fill = 'FF8811',
            stroke = 'FF8811',
        },
    },

    checkbox = {
        icon = '555555',
        stroke = 'FF8811',
        text = '555555',
    },

    simple_popup = {
        root = 'FBFAFF',
        title = '6462E3',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '6462E3',
    },

    game_area = {
        cell_note_text = {
            text = '555555',
        },

        grid = {
            stroke = '8A88FF',
            lines = 'A3A3A3',
            region_lines = '8A88FF',
            wrapper = 'FBFAFF',
        },

        draggable_number = {
            text = '555555',
        },

        grid_number = {
            primary = {
                number = '555555',
            },
            inserted = {
                number = '5F5DDB',
            },
            error = {
                number = 'FC1313',
            },
        },

        grid_cell = {
            primary = {
                base = {
                    bg = 'FBFAFF',
                    pfx = '6462E3',
                },
                selection = {
                    bg = 'E2CEEC',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'D5D0D8',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'BDCCFF',
                },
                transitions = {{
                    bg = 'BDCCFF',
                }, {
                    bg = 'C7D3FF',
                }, {
                    bg = 'D0DBFF',
                }, {
                    bg = 'E7ECFF',
                }, {
                    bg = 'FBFAFF',
                }},
            },
            error = {
                base = {
                    bg = 'FBFAFF',
                },
                selection = {
                    bg = 'E2CEEC',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'D5D0D8',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'BDCCFF',
                },
                transitions = {{
                    bg = 'BDCCFF',
                }, {
                    bg = 'C7D3FF',
                }, {
                    bg = 'D0DBFF',
                }, {
                    bg = 'E7ECFF',
                }, {
                    bg = 'FBFAFF',
                }},
            },
        },

        nums_panel = {
            wrapper = 'FBFAFF',
        },

        nums_panel_number = {
            primary = {
                base = {
                    text = '555555',
                    bg = 'FBFAFF',
                },
                selection = {
                    text = '555555',
                    bg = 'E5E5E5',
                },
            },
            notes = {
                base = {
                    text = '6462E3',
                    bg = 'EDEDED',
                },
                selection = {
                    text = '6462E3',
                    bg = 'D5D5D5',
                },
            },
        },

        tool_button = {
            primary = {
                text = '555555',
                icon = '555555',
            },
            click = {
                text = '6462E3',
                icon = '6462E3',
            },
        },

        hint_count = {
            free = {
                text = 'FFFFFF',
                bg = 'FF8811',
            },
        },

        hint_count_rewarded_icon = {
            bg = '6462E3',
        },

        hint_count_rewarded_timer = {
            text = '555555',
            bg = 'EDEDED',
        },
    },
}

LightTheme.settings_screen = {
    root = {
        bg = 'FBFAFF',
        settings_container = 'EDEDED',
        version_label = '555555',
        setting_titles = '555555',
    },

    switch = {
        enabled = {
            container = 'FFCD32',
            icon = 'FF8811',
        },
        disabled = {
            container = 'CACACA',
            icon = '818181',
        },
    },

    radio_button = {
        enabled = {
            container = 'FFCD32',
            icon = 'FF8811',
            title = '555555',
        },
        disabled = {
            container = 'CACACA',
            icon = '818181',
            title = '555555',
        },
    },

    button_save_progress = {
        container = '8583FF',
        icon = 'FBFAFF',
        text = 'FFFFFF',
    },

    platform_logo = {
        yandex = {
            icon = 'E02226',
            bg = 'FBFAFF',
        },
    },

    auth_status = {
        primary = {
            icon = '8583FF',
            text = '555555',
        },
        warning = {
            icon = 'FF8811',
            text = '555555',
        },
    },
}

LightTheme.game_screen = {
    root = {
        difficulty_label = '9998C2',
        errors_label = '9998C2',
        bg = 'FBFAFF',
    },

    timer = {
        timer_label = '555555',
        pause_button = '555555',
        container = 'EDEDED',
    },
}

LightTheme.start_screen = {
    root = {
        bg = 'FBFAFF',
        arrows = '818181',
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
            bg = '6462E3',
        },
        disabled = {
            title = 'FFFFFF',
            bg = 'CACACA',
        },
    },

    button_new_game = {
        title = 'FFFFFF',
        last_game_text = 'FFFFFF',
        bg = '8583FF',
    },

    secondary_buttons = {
        primary = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = '8583FF',
        },
        disabled = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = 'CACACA',
        },
    },
}

LightTheme.difficulty_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
        button_close = '818181',
    },

    item = {
        primary = {
            title = '555555',
            bg = 'FBFAFF22',
            points_text = '555555',
            points_icon = '555555',
            icon_inaccessible = '555555',
        },
        selection = {
            title = '555555',
            bg = '69696922',
        },

        icon = {
            filled = '555555',
            blank = 'CACACA',
        },
        master_icon = {
            icon = '555555',
        },
    },
    tooltip = {
        bg = 'FFCD32',
        text = '555555',
    },
    warning = {
        icon_bg = 'FF8811',
        icon_text = 'FFFFFF',
        text = '555555',
    },
}

LightTheme.stats_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '8E8CFF',
    },

    difficulty_stat_item = {
        main = '555555',
        icon = '555555',
        title = '555555',
        value = '555555',
    },

    common_section = {
        container = 'EDEDED',
        title = '555555',
        value = '555555',
    },

    difficulty_section = {
        container = 'EDEDED',
        title = '555555',
    },

    arrows = {
        stroke = '7D7F81',
        icon = '555555',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '818181',
        },
    },
}

LightTheme.defeat_popup = {
    root = {
        title = '6462E3',
        icon_bg = 'EDEDED',
        bg = 'FBFAFF',
    },

    button_undo_error = {
        bg = '8583FF',
        title = 'FFFFFF',
        icon = 'FFFFFF',
    },

    buttons_flat = {
        title = '6462E3',
    },
}

LightTheme.victory_screen = {
    root = {
        praise = '6462E3',
        bg = 'FBFAFF',
    },

    button_home = {
        title = 'FFFFFF',
        bg = '8583FF',
    },

    button_new_game = {
        title = 'FFFFFF',
        bg = '6462E3',
    },

    level_spec = {
        title = '555555',
        value = '555555',
        icon = '555555',
        icon_difficulty_part = 'CACACA',
    },
}

LightTheme.pause_popup = {
    root = {
        title = '6462E3',
        bg = 'FBFAFF',
        button_close = '818181',
    },

    specs = {
        container = 'EDEDED',
        titles = '555555',
        values = '555555',
    },

    button_continue = {
        title = 'FFFFFF',
        bg = '6462E3',
    },

    fact = {
        icon = '555555',
        title = '555555',
        text = '555555',
    },
}

LightTheme.store_screen = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
    },

    pack_header = {
        bg = 'FF8811',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = '8583FF',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '8583FF',
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
        text = '555555',
    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = '555555',
    },

    product_simple = {
        text = '555555',
        icon = '555555',
    },
}

LightTheme.post_purchase_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '6462E3',
        pack_title = '555555',
    },

    pack_item = {
        text = '555555',
        icon = '555555',
    },
}

LightTheme.reward_rate_game_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '6462E3',
    },
}

LightTheme.rating_unlock_popup = {
    root = {
        bg = 'FBFAFF',
        title = '6462E3',
        text = '555555',
        text_completed = '6462E3',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '6462E3',
    },
}

LightTheme.help_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '6462E3',
        texts = '555555',
        arrow = '818181',
        ranks_section_bg = 'FBFAFF',
        elems_highlight = '8583FF',
    },

    arrows = {
        primary = {
            stroke = 'CACACA',
            inner = '818181',
        },
    },

    drag_drop_section_draggable = {
        text = '8583FF',
        bg = 'FBFAFF',
    },

    rules_section = {
        cells_colors = {
            purple = 'E2CEEC',
            yellow = 'FDE8AD',
            pink = 'F6C3D1',
            center = 'FAC791',
        },
    },

    difficulty_icon = {
        filled = '555555',
        blank = 'CACACA',
    },

    slider_indicator = {
        primary = {
            bg = 'CACACA',
        },
        active = {
            bg = '818181',
        },
    },
}

LightTheme.starter_pack_offer_popup = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
        title = '6462E3',
        button_close = '818181',
    },

    pack_header = {
        bg = 'FF8811',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = '8583FF',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '8583FF',
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
        text = '555555',
    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = '555555',
    },

    product_simple = {
        text = '555555',
        icon = '555555',
    },
}

return LightTheme
