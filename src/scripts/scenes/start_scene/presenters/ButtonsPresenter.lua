local App = require('src.app')
local GUI = require('gui.gui')
local SceneCommon = require('src.scripts.scenes.start_scene.common.common')

local ButtonsMenu = GUI.ButtonsMenu
local SubscriptionsMap = App.libs.SubscriptionsMap
local Async = App.libs.async

local ButtonsID = App.constants.gui.screens.start_scene.buttons
local URL = App.constants.urls
local MSG = App.constants.msg
local UIConfig = App.config.ui.start_scene

--- @class ButtonsPresenterStartScreen
local ButtonsPresenter = class('ButtonsPresenter')

function ButtonsPresenter:initialize(view)
    --- @type ViewStartScene
    self.view = view
end

return ButtonsPresenter
