local GreenTheme = {}

GreenTheme.common_pallettes = {
    disabled = {
        text = 'FFFFFF',
        graphics = 'BABABA',
    },
}

GreenTheme.rating_help_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
        steps_texts = '555555',
        steps_icons_bg = 'EDEDED',
        header_buttons = '818181',
        arrows = '58595B',
    },

    button_rating = {
        title = 'FFFFFF',
        bg = '276F37',
    },

    button_ok = {
        title = 'FFFFFF',
        bg = '348D47',
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

GreenTheme.rating_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
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
        bg = 'D7EFAC',
        user_icon_stroke = '348D47',
        rank_text = 'FFFFFF',
        username = '348D47',
        points_text = '348D47',
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

GreenTheme.common = {
    background = 'FBFAFF',
    version_label = '818181',

    keyboard = {
        keys = 'FBFAFF',
        selected = '348D47',
        bg = 'D8D8D8',
    },

    appbar_theme_tool = {
        root = {
            bg = 'D6EEAC',
        },
        color = {
            selection = '348D47',
            lock = 'FBFAFF',
        },
    },

    appbar_platform = {
        root = '9FC856',
        buttons = 'FBFAFF',
        account_title = 'FBFAFF',
        plaftorm_logo = {
            yandex = {
                icon = 'E02226',
                bg = 'FBFAFF',
            },
        },
        special_offer_indicator = 'FF8811',
    },

    appbar_with_rank = {
        root = {
            bg = '9FC856',
            buttons = 'FFFFFF',
            rank_title = 'FFFFFF',
            rank_percentage = 'FFFFFF',
            rank_icon = 'FFFFFF',
            rank_icon_bg = '719E20',
            special_offer_indicator = 'FF8811',
        },

        star = {
            fill = 'FFFFFF',
            stroke = 'FFFFFF',
        },
    },

    appbar_simple = {
        container = '9FC856',
        button = 'FFFFFF',
        title = 'FFFFFF',
    },

    slider_indicator = {
        primary = {
            bg = '9FC856',
        },
        active = {
            bg = '276F37',
        },
    },

    rank_widget = {
        texts = {
            rank_title = '555555',
            pfx = 'FF8811',
            percentage = '555555',
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
            filled = '348D47',
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
        stroke = 'FFAE20',
        text = '555555',
    },

    simple_popup = {
        root = 'FBFAFF',
        title = '348D47',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '348D47',
    },

    game_area = {
        cell_note_text = {
            text = '555555',
        },

        grid = {
            stroke = '9FC856',
            lines = 'A3A3A3',
            region_lines = '9FC856',
            wrapper = 'FBFAFF',
        },

        grid_number = {
            primary = {
                number = '555555',
            },
            inserted = {
                number = '348D47',
            },
            error = {
                number = 'FC1313',
            },
        },

        draggable_number = {
            text = '555555',
        },

        nums_panel = {
            wrapper = 'FBFAFF',
        },

        grid_cell = {
            primary = {
                base = {
                    bg = 'FBFAFF',
                    pfx = '276F37',
                },
                selection = {
                    bg = 'D7EFAC',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'D1DFD4',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'D7EFAC',
                },
                transitions = {{
                    bg = 'D7EFAC',
                }, {
                    bg = 'E0F4B9',
                }, {
                    bg = 'EAFACC',
                }, {
                    bg = 'F4FFE0',
                }, {
                    bg = 'FBFAFF',
                }},
            },
            error = {
                base = {
                    bg = 'FBFAFF',
                },
                selection = {
                    bg = 'D7EFAC',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'D1DFD4',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'D7EFAC',
                },
                transitions = {{
                    bg = 'D7EFAC',
                }, {
                    bg = 'E0F4B9',
                }, {
                    bg = 'EAFACC',
                }, {
                    bg = 'F4FFE0',
                }, {
                    bg = 'FBFAFF',
                }},
            },
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
                    text = '348D47',
                    bg = 'EDEDED',
                },
                selection = {
                    text = '348D47',
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
                text = '348D47',
                icon = '348D47',
            },
        },

        hint_count = {
            free = {
                text = 'FFFFFF',
                bg = 'FF8811',
            },
        },

        hint_count_rewarded_icon = {
            bg = '348D47',
        },

        hint_count_rewarded_timer = {
            text = '555555',
            bg = 'EDEDED',
        },
    },
}

GreenTheme.settings_screen = {
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
        container = '348D47',
        icon = 'FBFAFF',
        text = 'FFFFFF',
    },

    platform_logo = {
        yandex = {
            icon = 'E02226',
            bg = 'FFFFFF',
        },
    },

    auth_status = {
        primary = {
            icon = '348D47',
            text = '555555',
        },
        warning = {
            icon = 'FF8811',
            text = '555555',
        },
    },
}

GreenTheme.game_screen = {
    root = {
        difficulty_label = '9FC856',
        errors_label = '9FC856',
        bg = 'FBFAFF',
    },

    timer = {
        timer_label = '555555',
        pause_button = '555555',
        container = 'EDEDED',
    },
}

GreenTheme.start_screen = {
    root = {
        bg = 'FBFAFF',
        arrows = '9FC856',
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
            bg = '276F37',
        },
        disabled = {
            title = 'FFFFFF',
            bg = 'BABABA',
        },
    },

    button_new_game = {
        title = 'FFFFFF',
        last_game_text = 'FFFFFF',
        bg = '348D47',
    },

    secondary_buttons = {
        primary = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = '348D47',
        },
        disabled = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = 'BABABA',
        },
    },
}

GreenTheme.difficulty_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
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

GreenTheme.stats_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '348D47',
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
        stroke = '9FC856',
        icon = '348D47',
    },

    slider_indicator = {
        primary = {
            bg = '9FC856',
        },
        active = {
            bg = '276F37',
        },
    },
}

GreenTheme.defeat_popup = {
    root = {
        title = '348D47',
        icon_bg = 'EDEDED',
        bg = 'FBFAFF',
    },

    button_undo_error = {
        bg = '348D47',
        title = 'FFFFFF',
        icon = 'FFFFFF',
    },

    buttons_flat = {
        title = '348D47',
    },
}

GreenTheme.victory_screen = {
    root = {
        praise = '348D47',
        bg = 'FBFAFF',
    },

    button_home = {
        title = 'FFFFFF',
        bg = '348D47',
    },

    button_new_game = {
        title = 'FFFFFF',
        bg = '276F37',
    },

    level_spec = {
        title = '555555',
        value = '555555',
        icon = '555555',
        icon_difficulty_part = 'CACACA',
    },
}

GreenTheme.pause_popup = {
    root = {
        title = '348D47',
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
        bg = '348D47',
    },

    fact = {
        icon = '555555',
        title = '555555',
        text = '555555',
    },
}

GreenTheme.store_screen = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
    },

    pack_header = {
        bg = 'FF8811',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = '348D47',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '348D47',
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

GreenTheme.post_purchase_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '348D47',
        pack_title = '555555',
    },

    pack_item = {
        text = '555555',
        icon = '555555',
    },
}

GreenTheme.reward_rate_game_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '348D47',
    },
}

GreenTheme.rating_unlock_popup = {
    root = {
        bg = 'FBFAFF',
        title = '348D47',
        text = '555555',
        text_completed = '348D47',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '348D47',
    },
}

GreenTheme.help_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '348D47',
        texts = '555555',
        arrow = '9FC856',
        ranks_section_bg = 'FBFAFF',
        elems_highlight = '348D47',
    },

    arrows = {
        primary = {
            stroke = '9FC856',
            inner = '348D47',
        },
    },

    rules_section = {
        cells_colors = {
            purple = 'E2CEEC',
            yellow = 'FDE8AD',
            pink = 'F6C3D1',
            center = 'FAC791',
        },
    },

    drag_drop_section_draggable = {
        text = '348D47',
        bg = 'FBFAFF',
    },

    difficulty_icon = {
        filled = '555555',
        blank = 'CACACA',
    },

    slider_indicator = {
        primary = {
            bg = '9FC856',
        },
        active = {
            bg = '276F37',
        },
    },
}

GreenTheme.starter_pack_offer_popup = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
        button_close = '818181',
        title = '348D47',
    },

    pack_header = {
        bg = 'FF8811',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = '348D47',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '348D47',
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

return GreenTheme
