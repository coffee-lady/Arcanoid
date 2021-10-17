local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local PlatformConfig = App.config.game.platform

--- @class BlocksPresenter
local BlocksPresenter = class('BlocksPresenter')

BlocksPresenter.__cparams = {'screen_service'}

function BlocksPresenter:initialize(screen_service, view)
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type ViewGameSceneGO
    self.view = view
end

function BlocksPresenter:create_block(settings)
    return self.view:create_block(settings)
end

function BlocksPresenter:get_block_size(id)
    return self.view:get_block_size(id)
end

function BlocksPresenter:set_block_pos(id, pos)
    self.view:set_block_pos(id, pos)
end

function BlocksPresenter:set_block_scale(id, scale_factor)
    self.view:set_block_scale(id, scale_factor)
end

return BlocksPresenter
