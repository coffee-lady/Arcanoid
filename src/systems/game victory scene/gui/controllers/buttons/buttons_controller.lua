local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game victory scene.gui.views.views')
local LevelService = Services.level

local ScenesService = Services.scenes

local URL = App.constants.urls
local GAME_SCENE_URL = URL.scenes.game_scene.main
local PACK_SELECTION_SCENE_URL = URL.scenes.pack_selection_scene.main
local START_SCENE_URL = URL.scenes.start_scene.main

local ButtonsView = Views.buttons

local ButtonsController = {}

function ButtonsController:init()
    local progress_level = LevelService:get_progress_level()
    local current_pack = LevelService:get_current_pack()

    self.is_passed_pack = progress_level < current_pack.first_level or progress_level > current_pack.last_level

    self.buttons_view = ButtonsView:new()

    self.buttons_view.next_observer:subscribe(function()
        local url = self.is_passed_pack and PACK_SELECTION_SCENE_URL or GAME_SCENE_URL
        ScenesService:switch_to_scene(url)
    end)

    self.buttons_view.back_observer:subscribe(function()
        ScenesService:switch_to_scene(START_SCENE_URL)
    end)
end

function ButtonsController:final()
    self.buttons_view:final()
end

return ButtonsController
