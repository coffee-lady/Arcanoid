local AppInstaller = require('src.scripts.app_installer.app_installer')

local SceneServiceLocator = {}

function SceneServiceLocator:init()
    AppInstaller:install(self)
end

return SceneServiceLocator
