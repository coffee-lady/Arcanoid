local App = require('src.app')
local Boost = require('src.common.classes.boost_view')

local BoostConfig = App.config.game.boosts.empty

local EmptyBoost = {
    weight = BoostConfig.weight
}

function EmptyBoost:init(message)
    Boost:new(message.pos, BoostConfig)
end

return EmptyBoost
