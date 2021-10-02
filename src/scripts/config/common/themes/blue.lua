local BlueTheme = {}

BlueTheme.common_pallettes = {
    disabled = {
        text = 'FFFFFF',
        graphics = 'CACACA',
    },
}

BlueTheme.common = {
    background = 'FBFAFF',
    version_label = '818181',

    keyboard = {
        keys = 'FBFAFF',
        selected = '238EEB',
        bg = 'D8D8D8',
    },

    appbar_theme_tool = {
        root = {
            bg = 'C2E1FA',
        },

        color = {
            selection = '238EEB',
            lock = 'FBFAFF',
        },
    },

    appbar_platform = {
        root = '4DAAF4',
        buttons = 'FFFFFF',
        account_title = 'FFFFFF',
        special_offer_indicator = 'FFAE20',
    },

    appbar_with_rank = {
        root = {
            bg = '4DAAF4',
            buttons = 'FFFFFF',
            rank_title = 'FFFFFF',
            rank_percentage = 'FFFFFF',
            rank_icon = '818181',
            rank_icon_bg = 'FFFFFF',
            special_offer_indicator = 'FFAE20',
        },

        star = {
            fill = 'FFFFFF',
            stroke = 'FFFFFF',
        },
    },

    appbar_simple = {
        container = '4DAAF4',
        button = 'FFFFFF',
        title = 'FFFFFF',
    },

    slider_indicator = {
        primary = {
            bg = 'A3D4FF',
        },
        active = {
            bg = '238EEB',
        },
    },

    rank_widget = {
        texts = {
            rank_title = '454545',
            pfx = '4DAAF4',
            percentage = '454545',
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
            filled = '4DAAF4',
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
        title = '238EEB',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '4DAAF4',
    },

    game_area = {
        cell_note_text = {
            text = '555555',
        },

        grid = {
            stroke = '4DAAF4',
            lines = 'A3A3A3',
            region_lines = '4DAAF4',
            wrapper = 'FBFAFF',
        },

        draggable_number = {
            text = '555555',
        },

        nums_panel = {
            wrapper = 'FBFAFF',
        },

        grid_number = {
            primary = {
                number = '555555',
            },
            inserted = {
                number = '238EEB',
            },
            error = {
                number = 'FC1313',
            },
        },

        grid_cell = {
            primary = {
                base = {
                    bg = 'FBFAFF',
                    pfx = '238EEB',
                },
                selection = {
                    bg = 'CCE8FF',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'C5D7E4',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'B4DEFF',
                },
                transitions = {{
                    bg = 'B4DEFF',
                }, {
                    bg = 'C7E6FF',
                }, {
                    bg = 'D6EDFF',
                }, {
                    bg = 'E4F3FF',
                }, {
                    bg = 'FBFAFF',
                }},
            },
            error = {
                base = {
                    bg = 'FBFAFF',
                },
                selection = {
                    bg = 'CCE8FF',
                },
                highlight = {
                    similar_region = {
                        bg = 'EDEDED',
                    },
                    similar_line = {
                        bg = 'EDEDED',
                    },
                    similar_num = {
                        bg = 'C5D7E4',
                    },
                    error_reason = {
                        bg = 'FFBABA',
                    },
                },

                start_transition = {
                    bg = 'B4DEFF',
                },
                transitions = {{
                    bg = 'B4DEFF',
                }, {
                    bg = 'C7E6FF',
                }, {
                    bg = 'D6EDFF',
                }, {
                    bg = 'E4F3FF',
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
                    text = '238EEB',
                    bg = 'F2F2F2',
                },
                selection = {
                    text = '238EEB',
                    bg = 'DCDCDC',
                },
            },
        },

        tool_button = {
            primary = {
                text = '555555',
                icon = '555555',
            },
            click = {
                text = '238EEB',
                icon = '238EEB',
            },
        },

        hint_count = {
            free = {
                text = 'FFFFFF',
                bg = 'FF8811',
            },
        },

        hint_count_rewarded_icon = {
            bg = '238EEB',
        },

        hint_count_rewarded_timer = {
            text = '555555',
            bg = 'EDEDED',
        },
    },
}

BlueTheme.rating_help_popup = {
    root = {
        bg = 'FFFFFF',
        title = '238EEB',
        steps_texts = '555555',
        steps_icons_bg = 'EDEDED',
        header_buttons = '818181',
        arrows = '58595B',
    },

    button_rating = {
        title = 'FFFFFF',
        bg = '238EEB',
    },

    button_ok = {
        title = 'FFFFFF',
        bg = '4DAAF4',
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

BlueTheme.rating_popup = {
    root = {
        bg = 'FFFFFF',
        title = '238EEB',
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
        bg = 'CCE8FF',
        user_icon_stroke = '238EEB',
        rank_text = 'FFFFFF',
        username = '2E94EC',
        points_text = '2E94EC',
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

BlueTheme.settings_screen = {
    root = {
        bg = 'FBFAFF',
        settings_container = 'EDEDED',
        version_label = '555555',
        setting_titles = '555555',
    },

    switch = {
        disabled = {
            container = 'CACACA',
            icon = '818181',
        },
        enabled = {
            container = 'FFF067',
            icon = 'FF8811',
        },
    },

    radio_button = {
        disabled = {
            container = 'CACACA',
            icon = '818181',
            title = '555555',
        },
        enabled = {
            container = 'FFF067',
            icon = 'FF8811',
            title = '555555',
        },
    },

    button_save_progress = {
        container = '4DAAF4',
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
            icon = '4DAAF4',
            text = '555555',
        },
        warning = {
            icon = 'FF8811',
            text = '555555',
        },
    },
}

BlueTheme.game_screen = {
    root = {
        difficulty_label = '555555',
        errors_label = '555555',
        bg = 'FBFAFF',
    },

    timer = {
        timer_label = '555555',
        pause_button = '555555',
        container = 'EDEDED',
    },
}

BlueTheme.start_screen = {
    root = {
        bg = 'FBFAFF',
        arrows = '7B7B7B',
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
            bg = '238EEB',
        },
        disabled = {
            title = 'FFFFFF',
            bg = 'CACACA',
        },
    },

    button_new_game = {
        title = 'FFFFFF',
        last_game_text = 'FFFFFF',
        bg = '4DAAF4',
    },

    secondary_buttons = {
        primary = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = '238EEB',
        },
        disabled = {
            title = '555555',
            icon = 'FBFAFF',
            icon_bg = 'CACACA',
        },
    },
}

BlueTheme.difficulty_popup = {
    root = {
        bg = 'FBFAFF',
        title = '238EEB',
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

BlueTheme.stats_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '238EEB',
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
        stroke = 'A3D4FF',
        icon = '238EEB',
    },

    slider_indicator = {
        primary = {
            bg = 'A3D4FF',
        },
        active = {
            bg = '238EEB',
        },
    },
}

BlueTheme.defeat_popup = {
    root = {
        title = '238EEB',
        icon_bg = 'EDEDED',
        bg = 'FBFAFF',
    },

    button_undo_error = {
        bg = '4DAAF4',
        title = 'FFFFFF',
        icon = 'FFFFFF',
    },

    buttons_flat = {
        title = '238EEB',
    },
}

BlueTheme.victory_screen = {
    root = {
        praise = '238EEB',
        bg = 'FBFAFF',
    },

    button_home = {
        title = 'FFFFFF',
        bg = '4DAAF4',
    },

    button_new_game = {
        title = 'FFFFFF',
        bg = '238EEB',
    },

    level_spec = {
        title = '555555',
        value = '555555',
        icon = '555555',
        icon_difficulty_part = 'CACACA',
    },
}

BlueTheme.pause_popup = {
    root = {
        title = '4DAAF4',
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
        bg = '4DAAF4',
    },

    fact = {
        icon = '555555',
        title = '555555',
        text = '555555',
    },
}

BlueTheme.store_screen = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
    },

    pack_header = {
        bg = 'FF8811',
        title = 'FFFFFF',
    },

    button_buy = {
        bg = '4DAAF4',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '4DAAF4',
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

BlueTheme.post_purchase_popup = {
    root = {
        bg = 'FBFAFF',
        title = '238EEB',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '4DAAF4',
        pack_title = '555555',
    },

    pack_item = {
        text = '555555',
        icon = '555555',
    },
}

BlueTheme.reward_rate_game_popup = {
    root = {
        bg = 'FBFAFF',
        title = '238EEB',
        text = '555555',
        icon_bg = 'EDEDED',
        button_close = '818181',
        button_next = '4DAAF4',
    },
}

BlueTheme.rating_unlock_popup = {
    root = {
        bg = 'FBFAFF',
        title = '238EEB',
        text = '555555',
        text_completed = '238EEB',
        button_close = '818181',
        button_next = '4DAAF4',
    },
}

BlueTheme.help_screen = {
    root = {
        bg = 'FBFAFF',
        titles = '238EEB',
        texts = '555555',
        arrow = '7B7B7B',
        ranks_section_bg = 'FBFAFF',
        elems_highlight = '238EEB',
    },

    arrows = {
        primary = {
            stroke = 'A3D4FF',
            inner = '238EEB',
        },
    },

    drag_drop_section_draggable = {
        text = '238EEB',
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
            bg = 'A3D4FF',
        },
        active = {
            bg = '238EEB',
        },
    },
}

BlueTheme.starter_pack_offer_popup = {
    root = {
        bg = 'FBFAFF',
        pack_container = 'EDEDED',
        title = '238EEB',
        button_close = '818181',
    },

    button_buy = {
        bg = '4DAAF4',
        text = 'FFFFFF',
    },

    button_buy_special = {
        bg = '4DAAF4',
        text = 'FFFFFF',
    },

    button_buy_special_timer = {
        container = 'FFAE20',
        icon = 'FFFFFF',
        text = 'FFFFFF',
    },

    button_buy_special_old_cost = {
        text = 'FFFFFF',
        line = 'FFAE20',
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

return BlueTheme
