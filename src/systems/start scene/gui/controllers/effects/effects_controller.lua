local App = require('src.app')
local URL = App.constants.urls

local SceneGuiUrl = URL.gui_nodes.start_scene

local EffectsController = {}

function EffectsController:init()
    local snow_pfx_node = gui.get_node(SceneGuiUrl.snow_particlefx)

    gui.play_particlefx(snow_pfx_node)
end

return EffectsController
