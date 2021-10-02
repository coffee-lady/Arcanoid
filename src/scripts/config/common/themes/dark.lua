local DarkTheme = {}

DarkTheme.common_pallettes = {
    disabled = {
        text = 'FFFFFF',
        graphics = '7D7F81',
    },
}

DarkTheme.rating_help_popup = {
    root = {
        bg = '3A3D42',
        title = '8E8CFF',
        steps_texts = 'DFDFE0',
        steps_icons_bg = '4C5057',
        header_buttons = '7D7F81',
        arrows = 'DFDFE0',
    },

    button_rating = {
        title = 'FFFFFF',
        bg = '7371F1',
    },

    button_ok = {
        title = 'FFFFFF',
        bg = '8E8CFF',
    },

    pedestal = {
        titles = '3A3D42',
        first_place = 'F3F3F3',
        second_place = 'CACED4',
        third_place = 'B4B8BE',
    },

    get_points = {
        icon = 'FFFFFF',
    },
}

DarkTheme.rating_popup = {
    root = {
        bg = '3A3D42',
        title = '8E8CFF',
        header_buttons = '7D7F81',
        scroll_divider = '27292D',
        loading_text = 'DFDFE0',
    },

    scroll_item_first_place = {
        bg = '4C5057',
        user_icon_stroke = 'FFD600',
        rank_text = '27292D',
        username = 'DFDFE0',
        points_text = 'DFDFE0',
    },

    scroll_item_second_place = {
        bg = '4C5057',
        user_icon_stroke = 'B2BED7',
        rank_text = '27292D',
        username = 'DFDFE0',
        points_text = 'DFDFE0',
    },

    scroll_item_third_place = {
        bg = '4C5057',
        user_icon_stroke = 'E09870',
        rank_text = '27292D',
        username = 'DFDFE0',
        points_text = 'DFDFE0',
    },

    scroll_item_current_user = {
        bg = '7576AA',
        user_icon_stroke = 'AAA9F0',
        rank_text = '27292D',
        username = 'FBFAFF',
        points_text = 'FBFAFF',
    },

    scroll_item_standard_user = {
        bg = '4C5057',
        user_icon_stroke = 'C0BBC6',
        rank_text = '27292D',
        username = 'DFDFE0',
        points_text = 'DFDFE0',
    },

    scrollbar = {
        container = '27292D',
        inner = '818181',
    },
}

DarkTheme.common = {
    background = '27292D',
    version_label = 'FFFFFF',

    keyboard = {
        keys = '27292D',
        selected = '8E8CFF',
        bg = '5B5E62',
    },

    appbar_theme_tool = {
        root = {
            bg = '50545B',
        },
        color = {
            selection = '8E8CFF',
            lock = '3A3D42',
        },
    },

    appbar_platform = {
        root = '3A3D42',
        buttons = 'F5F5F5',
        account_title = 'F5F5F5',
        special_offer_indicator = 'FF8811',
    },

    appbar_with_rank = {
        root = {
            bg = '3A3D42',
            buttons = 'F5F5F5',
            rank_title = 'F5F5F5',
            rank_percentage = 'F5F5F5',
            rank_icon = 'F5F5F5',
            rank_icon_bg = '27292D',
            special_offer_indicator = 'FF8811',
        },

        star = {
            fill = 'FF8811',
            stroke = 'FF8811',
        },
    },

    appbar_simple = {
        container = '3A3D42',
        button = 'F5F5F5',
        title = 'F5F5F5',
    },

    slider_indicator = {
        primary = {
            bg = '3A3D42',
        },
        active = {
            bg = '7D7F81',
        },
    },

    rank_widget = {
        texts = {
            rank_title = 'DFDFE0',
            pfx = '7371F1',
            percentage = 'DFDFE0',
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
            blank = '7D7F81',
        },
        progressbar_star = {
            fill = 'FF8811',
            stroke = '27292D',
        },
        rank_star = {
            fill = 'FF8811',
            stroke = 'FF8811',
        },
    },

    checkbox = {
        icon = 'DFDFE0',
        stroke = 'FF8811',
        text = 'DFDFE0',
    },

    simple_popup = {
        root = '3A3D42',
        title = '8E8CFF',
        text = 'DFDFE0',
        icon_bg = 'EDEDED',
        button_close = '7D7F81',
        button_next = '7371F1',
    },

    game_area = {
        cell_note_text = {
            text = 'DFDFE0',
        },

        grid = {
            stroke = '9593E5',
            lines = '595E64',
            region_lines = '9593E5',
            wrapper = '27292D',
        },

        draggable_number = {
            text = 'DFDFE0',
        },

        grid_number = {
            primary = {
                number = 'DFDFE0',
            },
            inserted = {
                number = '8E8CFF',
            },
            error = {
                number = 'FF4343',
            },
        },

        grid_cell = {
            primary = {
                base = {
                    bg = '27292D',
                    pfx = '7371F1',
                },
                selection = {
                    bg = '675684',
                },
                highlight = {
                    similar_region = {
                        bg = '3E4147',
                    },
                    similar_line = {
                        bg = '3E4147',
                    },
                    similar_num = {
                        bg = '4D576C',
                    },
                    error_reason = {
                        bg = '75464C',
                    },
                },
                start_transition = {
                    bg = '535477',
                },
                transitions = {{
                    bg = '535477',
                }, {
                    bg = '484965',
                }, {
                    bg = '3D3E52',
                }, {
                    bg = '323440',
                }, {
                    bg = '27292D',
                }},
            },
            error = {
                base = {
                    bg = '27292D',
                },
                selection = {
                    bg = '675684',
                },
                highlight = {
                    similar_region = {
                        bg = '3E4147',
                    },
                    similar_line = {
                        bg = '3E4147',
                    },
                    similar_num = {
                        bg = '4D576C',
                    },
                    error_reason = {
                        bg = '75464C',
                    },
                },
                start_transition = {
                    bg = '535477',
                },
                transitions = {{
                    bg = '535477',
                }, {
                    bg = '484965',
                }, {
                    bg = '3D3E52',
                }, {
                    bg = '323440',
                }, {
                    bg = '27292D',
                }},
            },
        },

        nums_panel = {
            wrapper = '27292D',
        },

        nums_panel_number = {
            primary = {
                base = {
                    text = 'DFDFE0',
                    bg = '27292D',
                },
                selection = {
                    text = 'DFDFE0',
                    bg = '3A3D42',
                },
            },
            notes = {
                base = {
                    text = '8E8CFF',
                    bg = '3A3D42',
                },
                selection = {
                    text = '8E8CFF',
                    bg = '4D5055',
                },
            },
        },

        tool_button = {
            primary = {
                text = 'DFDFE0',
                icon = 'DFDFE0',
            },
            click = {
                text = '8E8CFF',
                icon = '8E8CFF',
            },
        },

        hint_count = {
            free = {
                text = '27292D',
                bg = 'FF8811',
            },
        },

        hint_count_rewarded_icon = {
            bg = '8E8CFF',
        },

        hint_count_rewarded_timer = {
            text = 'DFDFE0',
            bg = '3A3D42',
        },
    },
}

DarkTheme.settings_screen = {
    root = {
        bg = '27292D',
        settings_container = '3A3D42',
        version_label = 'DFDFE0',
        setting_titles = 'DFDFE0',
    },

    switch = {
        enabled = {
            container = 'FFCD32',
            icon = 'FF8811',
        },
        disabled = {
            container = '27292D',
            icon = '818181',
        },
    },

    radio_button = {
        enabled = {
            container = 'FFCD32',
            icon = 'FF8811',
            title = 'DFDFE0',
        },
        disabled = {
            container = '27292D',
            icon = '818181',
            title = 'DFDFE0',
        },
    },

    button_save_progress = {
        container = '7371F1',
        icon = 'FBFAFF',
        text = 'FFFFFF',
    },

    platform_logo = {
        yandex = {
            icon = 'F5F5F5',
            bg = '27292D',
        },
    },

    auth_status = {
        primary = {
            icon = '7370F1',
            text = 'DFDFE0',
        },
        warning = {
            icon = 'FF8811',
            text = 'DFDFE0',
        },
    },
}

DarkTheme.game_screen = {
    root = {
        difficulty_label = '9593E5',
        errors_label = '9593E5',
        bg = '27292D',
    },

    timer = {
        timer_label = 'DFDFE0',
        pause_button = 'DFDFE0',
        container = '3A3D42',
    },
}

DarkTheme.start_screen = {
    root = {
        bg = '27292D',
        arrows = 'DFDFE0',
    },

    platform_logo = {
        yandex = {
            icon = 'F5F5F5',
            bg = '27292D',
        },
    },

    button_continue_game = {
        primary = {
            title = 'FFFFFF',
            bg = '7371F1',
        },
        disabled = {
            title = 'FFFFFF',
            bg = 'CACACA',
        },
    },

    button_new_game = {
        title = 'FFFFFF',
        last_game_text = 'FFFFFF',
        bg = '8E8CFF',
    },

    secondary_buttons = {
        primary = {
            title = 'DFDFE0',
            icon = '3A3D42',
            icon_bg = '8E8CFF',
        },
        disabled = {
            title = 'DFDFE0',
            icon = '3A3D42',
            icon_bg = '7D7F81',
        },
    },
}

DarkTheme.difficulty_popup = {
    root = {
        bg = '3A3D42',
        title = 'F5F5F5',
        button_close = '7D7F81',
    },

    item = {
        primary = {
            title = 'DFDFE0',
            bg = '3A3D42',
            points_text = 'DFDFE0',
            points_icon = 'DFDFE0',
            icon_inaccessible = 'DFDFE0',
        },

        selection = {
            title = 'DFDFE0',
            bg = '69696922',
        },

        icon = {
            filled = 'DFDFE0',
            blank = '7D7F81',
        },
        master_icon = {
            icon = 'DFDFE0',
        },
    },
    tooltip = {
        bg = 'FFCD32',
        text = '3A3D42',
    },
    warning = {
        icon_bg = 'FF8811',
        icon_text = '3A3D42',
        text = 'DFDFE0',
    },
}

DarkTheme.stats_screen = {
    root = {
        bg = '27292D',
        titles = '8E8CFF',
    },

    difficulty_stat_item = {
        main = 'DFDFE0',
        icon = 'DFDFE0',
        title = 'DFDFE0',
        value = 'DFDFE0',
    },

    common_section = {
        container = '3A3D42',
        title = 'DFDFE0',
        value = 'DFDFE0',
    },

    difficulty_section = {
        container = '3A3D42',
        title = 'DFDFE0',
    },

    arrows = {
        stroke = '7D7F81',
        icon = 'DFDFE0',
    },

    slider_indicator = {
        primary = {
            bg = '3A3D42',
        },
        active = {
            bg = '7D7F81',
        },
    },
}

DarkTheme.defeat_popup = {
    root = {
        title = '8E8CFF',
        icon_bg = '4C5057',
        bg = '3A3D42',
    },

    button_undo_error = {
        bg = '7371F1',
        title = 'FFFFFF',
        icon = 'FFFFFF',
    },

    buttons_flat = {
        title = 'DFDFE0',
    },
}

DarkTheme.victory_screen = {
    root = {
        praise = '8E8CFF',
        bg = '27292D',
    },

    button_home = {
        title = 'FFFFFF',
        bg = '8E8CFF',
    },

    button_new_game = {
        title = 'FFFFFF',
        bg = '7371F1',
    },

    level_spec = {
        title = 'DFDFE0',
        value = 'DFDFE0',
        icon = 'DFDFE0',
        icon_difficulty_part = '7D7F81',
    },
}

DarkTheme.pause_popup = {
    root = {
        title = '8E8CFF',
        bg = '3A3D42',
        button_close = '7D7F81',
    },

    specs = {
        container = '4C5057',
        titles = 'DFDFE0',
        values = 'DFDFE0',
    },

    button_continue = {
        title = 'FFFFFF',
        bg = '7371F1',
    },

    fact = {
        icon = 'DFDFE0',
        title = 'DFDFE0',
        text = 'DFDFE0',
    },
}

DarkTheme.store_screen = {
    root = {
        bg = '27292D',
        pack_container = '3A3D42',
    },

    pack_header = {
        bg = 'FF8811',
        title = '3A3D42',
    },

    button_buy = {
        bg = '7371F1',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '7371F1',
        text = 'FFFFFF',
    },

    button_buy_special_timer = {
        container = 'FF8811',
        icon = '3A3D42',
        text = '3A3D42',
    },

    button_buy_special_old_cost = {
        text = 'FFFFFF',
        line = 'FF8811',
    },

    product_with_title = {
        text = 'DFDFE0',

    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = 'DFDFE0',
    },

    product_simple = {
        text = 'DFDFE0',
        icon = 'DFDFE0',
    },
}

DarkTheme.post_purchase_popup = {
    root = {
        bg = '3A3D42',
        title = '8E8CFF',
        text = 'DFDFE0',
        icon_bg = 'EDEDED',
        button_close = '7D7F81',
        button_next = '7371F1',
        pack_title = 'DFDFE0',
    },

    pack_item = {
        text = 'DFDFE0',
        icon = 'DFDFE0',
    },
}

DarkTheme.reward_rate_game_popup = {
    root = {
        bg = '3A3D42',
        title = '8E8CFF',
        text = 'DFDFE0',
        icon_bg = 'EDEDED',
        button_close = '7D7F81',
        button_next = '7371F1',
    },
}

DarkTheme.rating_unlock_popup = {
    root = {
        bg = '3A3D42',
        title = '8E8CFF',
        text = 'DFDFE0',
        text_completed = 'DFDFE0',
        icon_bg = '4C5057',
        button_close = '7D7F81',
        button_next = '7371F1',
    },
}

DarkTheme.help_screen = {
    root = {
        bg = '27292D',
        titles = '8E8CFF',
        texts = 'DFDFE0',
        arrow = '7D7F81',
        ranks_section_bg = '27292D',
        elems_highlight = '8E8CFF',
    },

    arrows = {
        primary = {
            stroke = '7D7F81',
            inner = 'CACACA',
        },
    },

    drag_drop_section_draggable = {
        text = 'DFDFE0',
        bg = '675684',
    },

    rules_section = {
        cells_colors = {
            purple = '43445E',
            yellow = '675A2F',
            pink = '623F4A',
            center = '916943',
        },
    },

    difficulty_icon = {
        filled = 'DFDFE0',
        blank = '7D7F81',
    },

    slider_indicator = {
        primary = {
            bg = '3A3D42',
        },
        active = {
            bg = '7D7F81',
        },
    },
}

DarkTheme.starter_pack_offer_popup = {
    root = {
        bg = '27292D',
        pack_container = '3A3D42',
        title = '8E8CFF',
        button_close = '7D7F81',
    },

    pack_header = {
        bg = 'FF8811',
        title = '3A3D42',
    },

    button_buy = {
        bg = '7371F1',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '7371F1',
        text = 'FFFFFF',
    },

    button_buy_special_timer = {
        container = 'FF8811',
        icon = '3A3D42',
        text = '3A3D42',
    },

    button_buy_special_old_cost = {
        text = 'FFFFFF',
        line = 'FF8811',
    },

    product_with_title = {
        text = 'DFDFE0',

    },

    product_with_title_icon = {
        outer = 'FF8811',
        inner = 'DFDFE0',
    },

    product_simple = {
        text = 'DFDFE0',
        icon = 'DFDFE0',
    },
}

return DarkTheme
