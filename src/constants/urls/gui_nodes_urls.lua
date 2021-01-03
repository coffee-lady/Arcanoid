local GuiNodesUrls = {
    game_pause_popup = {
        root = 'root',
        button_restart = 'button_restart',
        button_back = 'button_back',
        button_continue = 'button_continue',
        text = {
            title = 'title',
            button_back_text = 'button_back_text',
            button_continue_text = 'button_continue_text',
            button_restart_text = 'button_restart_text'
        }
    },
    game_losing_popup = {
        root = 'root',
        button_restart = 'button_restart',
        button_back = 'button_back',
        button_buy = 'button_buy',
        text = {
            title = 'title',
            button_restart_text = 'button_restart_text',
            button_back_text = 'button_back_text',
            energy_container_count = 'energy_container_count',
            energy_container_left = 'energy_container_left',
            button_buy_text = 'button_buy_text'
        }
    },
    game_scene = {
        root = 'root',
        transition = 'transition',
        life = 'life',
        energy_container = 'energy_container',
        pause_button = 'pause_button',
        pause_container = 'pause_container',
        text = {
            pause_text = 'pause_text',
            energy_amount = 'energy_amount'
        }
    },
    game_victory_scene = {
        root = 'root',
        bg = 'bg',
        transition = 'transition',

        particlefx = {
            snow_particlefx = 'snow_particlefx',
            win_particlefx1 = 'win_particlefx1',
            win_particlefx2 = 'win_particlefx2',
            win_particlefx3 = 'win_particlefx3'
        },

        pack_icon = 'pack_icon',
        button_next = 'button_next',
        button_back = 'button_back',
        text = {
            title = 'title',
            congrats_text = 'congrats_text',
            level_title = 'level_title',
            pack_title = 'pack_title',
            button_next_text = 'button_next_text',
            button_back_text = 'button_back_text',
            energy_container_count = 'energy_container_count',
            energy_container_left = 'energy_container_left'
        }
    },
    pack_selection_scene = {
        root = 'root',
        transition = 'transition',
        bottom_panel = 'bottom_panel',
        pack_icon = 'pack_icon',
        list = 'list',
        list_mask = 'list_mask',
        list_item = 'list_item',
        list_item_icon = 'list_item_icon',
        list_item_texts = {
            list_item_pack_title = 'list_item_pack_title',
            list_item_level_title = 'list_item_level_title'
        },
        text = {
            level_title = 'level_title',
            pack_title = 'pack_title',
            continue_text = 'continue_text',
            energy_container_count = 'energy_container_count',
            energy_container_left = 'energy_container_left'
        }
    },
    start_scene = {
        root = 'root',
        transition = 'transition',
        snow_particlefx = 'snow_particlefx',
        button_play = 'button_play',
        text = {
            title = 'title',
            button_play_text = 'button_play_text',
            energy_container_count = 'energy_container_count',
            energy_container_left = 'energy_container_left'
        }
    }
}

return GuiNodesUrls
