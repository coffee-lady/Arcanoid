local App = require('src.app')

local SoundsMSG = App.constants.msg.sounds
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_SOUNDS_DISABLED = FilesConfig.keys.is_sound_disabled

local DEBUG = App.config.debug_mode.SoundService
local GATE_TIME = 0.3

local Async = App.libs.async
local Debug = App.libs.debug

local SoundService = {}

function SoundService:init(global_go_caller_service, player_data_storage)
    self.global_go_caller_service = global_go_caller_service
    self.player_data_storage = player_data_storage
    self.sounds_disabled = self.player_data_storage:get(FILE, KEY_SOUNDS_DISABLED)

    self.debug = Debug('[SoundService]', DEBUG)

    self.gated_sounds = {}

    self.global_go_caller_service:set_callback(SoundsMSG._play_sound, function(url, play_properties)
        self.debug:log('play', url, self.debug:inspect(play_properties))
        sound.play(url, play_properties)
    end)

    self.global_go_caller_service:set_callback(SoundsMSG._pause_sound, function(url, is_paused)
        self.debug:log('pause', url, is_paused)
        sound.pause(url, is_paused)
    end)

    self.global_go_caller_service:set_callback(SoundsMSG._stop_sound, function(url)
        self.debug:log('stop', url)
        sound.stop(url)
    end)
end

function SoundService:toggle_sounds()
    if self.sounds_disabled then
        self:enable_sounds()
    else
        self:disable_sounds()
    end
end

function SoundService:enable_sounds()
    self.sounds_disabled = false
    self.player_data_storage:set(FILE, KEY_SOUNDS_DISABLED, self.sounds_disabled)
end

function SoundService:disable_sounds()
    self.sounds_disabled = true
    self.player_data_storage:set(FILE, KEY_SOUNDS_DISABLED, self.sounds_disabled)
end

function SoundService:is_sound_enabled()
    return not self.sounds_disabled
end

function SoundService:play(url, play_properties)
    if self.sounds_disabled then
        return
    end

    self.global_go_caller_service:call(SoundsMSG._play_sound, url, play_properties)
end

function SoundService:play_force(url, play_properties)
    self.global_go_caller_service:call(SoundsMSG._play_sound, url, play_properties)
end

function SoundService:play_async(url, play_properties)
    if self.sounds_disabled then
        return
    end

    local tmp_play_sound = hash('_tmp_play_sound')

    Async(function(done)
        self.global_go_caller_service:set_callback(tmp_play_sound, function()
            sound.play(url, play_properties, function()
                done()
            end)
        end)

        self.global_go_caller_service:call(tmp_play_sound, url, play_properties)
    end)
end

function SoundService:pause(url)
    if self.sounds_disabled then
        return
    end

    self.global_go_caller_service:call(SoundsMSG._pause_sound, url, true)
end

function SoundService:resume(url)
    if self.sounds_disabled then
        return
    end

    self.global_go_caller_service:call(SoundsMSG._pause_sound, url, false)
end

function SoundService:stop(url)
    if self.sounds_disabled then
        return
    end

    self.global_go_caller_service:call(SoundsMSG._stop_sound, url)
end

function SoundService:update(dt)
    for key, _ in pairs(self.gated_sounds) do
        self.gated_sounds[key] = self.gated_sounds[key] - dt
        if self.gated_sounds[key] < 0 then
            self.gated_sounds[key] = nil
        end
    end
end

function SoundService:play_gated_sound(url, play_properties)
    if self.gated_sounds[url] then
        return
    end

    self.gated_sounds[url] = GATE_TIME
    self.global_go_caller_service:call(SoundsMSG._play_sound, url, play_properties)
end

return SoundService
