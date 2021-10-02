local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.screens.start_screen
local ButtonsID = ID.buttons

local TextNode = GUI.TextNode
local BoxNode = GUI.BoxNode
local NodesList = GUI.NodesList

local Nodes = {}

function Nodes:init()
    self.nodes = {
        root = BoxNode(ID.root),
        fades = NodesList(BoxNode(ID.fade_left), BoxNode(ID.fade_right)),
        arrows = NodesList(BoxNode(ID.arrow_next.inner), BoxNode(ID.arrow_prev.inner)),
        version_label = TextNode(ID.version),

        buttons = {
            continue_game = {
                container = BoxNode(ButtonsID.continue_game.inner),
                title = TextNode(ButtonsID.continue_game.text),
                subtext = BoxNode(ButtonsID.continue_game.subtext_container),
                subtext_text = TextNode(ButtonsID.continue_game.subtext_text),
                subtext_icon = BoxNode(ButtonsID.continue_game.subtext_icon),
            },

            new_game = {
                container = BoxNode(ButtonsID.new_game.inner),
                title = TextNode(ButtonsID.new_game.text),
            },

            game_events = {
                title = TextNode(ButtonsID.game_events.text),
                icon = BoxNode(ButtonsID.game_events.icon),
                inner = BoxNode(ButtonsID.game_events.inner),
            },

            rating_button = {
                title = TextNode(ButtonsID.rating_button.text),
                icon = BoxNode(ButtonsID.rating_button.icon),
                inner = BoxNode(ButtonsID.rating_button.inner),
            },

            daily_tasks = {
                title = TextNode(ButtonsID.daily_tasks.text),
                icon = BoxNode(ButtonsID.daily_tasks.icon),
                inner = BoxNode(ButtonsID.daily_tasks.inner),
            },
        },
    }
end

function Nodes:get_objects()
    return self.nodes
end

return Nodes
