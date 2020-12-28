local App = require('src.app')
local class = App.libs.middleclass
local URL = App.constants.urls
local SceneURLs = URL.gui_nodes.start_scene

local Animations = class('Animations')

function Animations:initialize()
    local snow_pfx_node = gui.get_node(SceneURLs.snow_particlefx)

    gui.play_particlefx(snow_pfx_node)
end

return Animations
