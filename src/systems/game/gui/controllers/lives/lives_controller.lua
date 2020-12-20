local Models = require('src.systems.game.gui.models.models')
local Views = require('src.systems.game.gui.views.views')

local Lives = Models.lives
local LivesView = Views.lives

local LivesController = {}

function LivesController:init()
    self.lives = Lives:new()
    self.lives_view = LivesView:new()

    self.lives.increase_observer:subscribe(function(count)
        self.lives_view:show(count)
    end)

    self.lives.decrease_observer:subscribe(function(count)
        self.lives_view:hide(count + 1)
    end)
end

return LivesController
