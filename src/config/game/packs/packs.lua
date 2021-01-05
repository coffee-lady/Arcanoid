local PacksConfig = {
    icon_closed = 'pack_icon_closed',
    gui_item_height = 150,
    even_list_item_color = vmath.vector4(0, 0.17, 0.22, 0.58),
    odd_list_item_color = vmath.vector4(0.11, 0.24, 0.32, 0.58),

    list = {{
        title = 'Christmas Deer',
        icon = 'pack_icon_blue_deer',
        first_level = 1,
        last_level = 5
    }, {
        title = 'Red Star',
        icon = 'pack_icon_red_star',
        first_level = 6,
        last_level = 6
    }, {
        title = 'Purple Snowflake',
        icon = 'pack_icon_purple_snowflake',
        first_level = 7,
        last_level = 11
    }}
}

return PacksConfig
