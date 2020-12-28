local App = require('src.app')
local Components = require('src.systems.pack selection scene.components.components')

local class = App.libs.middleclass
local PacksConfig = App.config.game.packs

local List = Components.packs_list
local ListItem = Components.packs_list_item

local Factory = {}

function Factory:init()
    local list_length = 0

    for i = 1, #PacksConfig.list do
        ListItem:new(i)

        list_length = list_length + 1
    end

    list_length = list_length * PacksConfig.gui_item_height

    List:new(list_length)
end

return Factory
