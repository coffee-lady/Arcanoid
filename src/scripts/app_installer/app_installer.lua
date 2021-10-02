local AppInstaller = {}

function AppInstaller:init(app_installer)
    self.app_installer = app_installer
end

function AppInstaller:install(context)
    self.app_installer:install(context)
end

function AppInstaller:install_services(context)
    self.app_installer:install_services(context)
end

return AppInstaller
