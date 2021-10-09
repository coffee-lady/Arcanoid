local Luject = require('src.libs.luject.luject')

--- @class SceneView
local SceneView = class('SceneView')

function SceneView:initialize(UIMaps)
    self.nodes_map = Luject:resolve_class(UIMaps.NodesMap)
    self.theme_map = Luject:resolve_class(UIMaps.ThemeMap, self.nodes_map)
    self.localization_map = Luject:resolve_class(UIMaps.LocalizationMap, self.nodes_map)
    self.controls_map = Luject:resolve_class(UIMaps.ControlsMap)
end

function SceneView:final()
    self.theme_map:final()
    self.localization_map:final()
end

return SceneView
