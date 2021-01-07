local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game victory scene.services.services')
local class = App.libs.middleclass

local AnimationsLib = App.libs.animations
local EnergyService = Services.energy
local LocalizationService = SceneServices.localization
local LevelService = Services.level
local GUIService = Services.gui

local PROP = App.constants.go_props

local Animation = AnimationsLib.animation
local Animator = AnimationsLib.animator
local AnimateCounter = AnimationsLib.counter

local AnimationsConfig = App.config.common.animations.game_victory_scene

local URL = App.constants.urls
local SceneURLs = URL.gui_nodes.game_victory_scene

local Animations = class('Animations')

function Animations:play()
    for _, pfx in pairs(SceneURLs.particlefx) do
        gui.play_particlefx(gui.get_node(pfx))
    end

    self:animate_pack_icon()
    self:animate_energy()
end

function Animations:animate_pack_icon()
    local prev_pack = LevelService:get_previous_pack()
    local current_pack = LevelService:get_current_pack()

    if prev_pack.icon == current_pack.icon then
        return
    end

    local config = AnimationsConfig.pack_icon

    local config_prev = {
        property = PROP.color_w,
        to = 0,
        duration = config.duration,
        easing = config.easing,
        delay = config.delay,
        playback = gui.PLAYBACK_ONCE_FORWARD
    }

    local config_next = {
        property = PROP.color_w,
        to = 1,
        duration = config.duration,
        easing = config.easing,
        delay = config.delay,
        playback = gui.PLAYBACK_ONCE_FORWARD
    }

    local icon_node = gui.get_node(SceneURLs.pack_icon)
    local anim_prev = Animation:new(icon_node, gui.animate, gui.cancel_animations, config_prev)
    local anim_next = Animation:new(icon_node, gui.animate, gui.cancel_animations, config_next)

    Animator():play(anim_prev):exec(function()
        GUIService.images:set({
            node = gui.get_node(SceneURLs.pack_icon),
            animation = current_pack.icon
        })
    end):play(anim_next)
end

function Animations:animate_level()
    local next_level = LevelService:get_current_level()
    local prev_level = next_level - 1

    local level_node_id = SceneURLs.text.level_title

    AnimateCounter(AnimationsConfig.level.duration, prev_level, next_level, function(level)
        LocalizationService:update_node(level_node_id, {
            next_level = level
        })
    end)
end

function Animations:animate_energy()
    local current_energy = EnergyService:get_current_energy()
    local prev_energy = current_energy - EnergyService:get_level_reward()

    local energy_node_id = SceneURLs.text.energy_container_count

    AnimateCounter(AnimationsConfig.energy.duration, prev_energy, current_energy, function(energy)
        LocalizationService:update_node(energy_node_id, {
            current_energy = energy,
            max_energy = EnergyService:get_max_energy()
        })
    end)
end

return Animations
