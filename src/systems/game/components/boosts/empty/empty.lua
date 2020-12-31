local App = require('src.app')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local BoostConfig = App.config.game.boosts.empty

local EmptyBoost = class('EmptyBoost', Boost)

EmptyBoost.weight = BoostConfig.weight

function EmptyBoost:initialize(id, message)
    Boost.initialize(self, id, BoostConfig)
end

return EmptyBoost
