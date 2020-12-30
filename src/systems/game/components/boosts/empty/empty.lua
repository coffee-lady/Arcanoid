local App = require('src.app')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local BoostConfig = App.config.game.boosts.empty

local EmptyBoost = class('EmptyBoost', Boost)

EmptyBoost.weight = BoostConfig.weight

function EmptyBoost:initialize()
    self.config = BoostConfig
end

return EmptyBoost
