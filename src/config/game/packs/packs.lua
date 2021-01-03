local PacksConfig = {
    icon_closed = 'pack_icon_closed',
    gui_item_height = 150,
    even_list_item_color = vmath.vector4(0, 0.17, 0.22, 0.58),
    odd_list_item_color = vmath.vector4(0.11, 0.24, 0.32, 0.58),

    list = {{
        title = 'Pack X',
        icon = 'pack_icon_blue_deer',
        first_level = 1,
        last_level = 1
    }, {
        title = 'Pack Y',
        icon = 'pack_icon_yellow_candle',
        first_level = 2,
        last_level = 4
    }, {
        title = 'Pack Z',
        icon = 'pack_icon_gold_snowflake',
        first_level = 5,
        last_level = 10
    }}
}

return PacksConfig
