local App = require('src.app')

local Debug = App.libs.debug

local HintsConfig = App.config.game.hints
local FreeHintsConfig = HintsConfig.free
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_FREE_HINTS = FilesConfig.keys.free_hints_count
local KEY_PAID_HINTS = FilesConfig.keys.paid_hints_count
local DEBUG = App.config.debug_mode.HintsService

local HintsDataService = {}

function HintsDataService:init(services)
    self.player_data_storage = services.player_data_storage

    self.debug = Debug('HintsDataService', DEBUG)
end

function HintsDataService:get_free_hints()
    return self.player_data_storage:get(FILE, KEY_FREE_HINTS) or FreeHintsConfig.count
end

function HintsDataService:get_paid_hints()
    return self.player_data_storage:get(FILE, KEY_PAID_HINTS) or 0
end

function HintsDataService:add_free_hints(add_count)
    local count = self:get_free_hints()
    self.player_data_storage:set(FILE, KEY_FREE_HINTS, count + add_count)
    self.debug:log('after adding', add_count, 'free hints to', count, '=', self:get_free_hints())
end

function HintsDataService:add_paid_hints(add_count)
    local count = self:get_paid_hints()
    self.player_data_storage:set(FILE, KEY_PAID_HINTS, count + add_count)
    self.debug:log('after adding', add_count, 'paid hints to', count, '=', self:get_paid_hints())
end

function HintsDataService:apply_free_hint()
    local count = self:get_free_hints()
    self.player_data_storage:set(FILE, KEY_FREE_HINTS, count - 1)
    self.debug:log('after applying from', count, 'free hints', self:get_free_hints())
end

function HintsDataService:apply_paid_hint()
    local count = self:get_paid_hints()
    self.player_data_storage:set(FILE, KEY_PAID_HINTS, count - 1)
    self.debug:log('after applying from', count, 'free hints', self:get_paid_hints())
end

return HintsDataService
