local App = require('src.app')
local URL = App.constants.urls

local GameGuiUrl = URL.gui_nodes.game_scene

local EffectsController = {}

function EffectsController:init()
    local snow_pfx_node = gui.get_node(GameGuiUrl.snow_particlefx)

    gui.play_particlefx(snow_pfx_node)
end

return EffectsController
