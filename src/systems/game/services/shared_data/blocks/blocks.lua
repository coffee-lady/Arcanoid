local App = require('src.app')
local SceneMsgService = require('src.systems.game.services.msg.msg')

local MSG = App.constants.messages
local URL = App.constants.urls

local BlocksData = {}

function BlocksData:init()
    self.blocks = {}
    self.destroyable_blocks = 0

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.block_destructed, function(message)
        self:remove(message.id)

        if message.destroyable then
            self.destroyable_blocks = self.destroyable_blocks - 1

            if self.destroyable_blocks == 0 then
                SceneMsgService:send(nil, MSG.game.winning)
                return
            end
        end

        SceneMsgService:send(nil, MSG.game.blocks_deleted, message)
    end)
end

function BlocksData:get()
    return self.blocks
end

function BlocksData:add(block)
    self.blocks[#self.blocks + 1] = block

    if block:is_destroyable() then
        self.destroyable_blocks = self.destroyable_blocks + 1
    end
end

function BlocksData:remove(id)
    for i = 1, #self.blocks do
        local block = self.blocks[i]
        if block.id == id then
            table.remove(self.blocks, i)
            break
        end
    end
end

return BlocksData
