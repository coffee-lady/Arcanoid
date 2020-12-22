local Block = require('src.systems.game.go.models.blocks.block_model')

local BlocksBuilder = {}

function BlocksBuilder:build(blocks, level_data, config)
    self.config = config
    self.level_data = level_data

    for _, row in pairs(self.level_data.grid) do
        for i = 1, #row do
            blocks[#blocks + 1] = Block:new(row[i])
        end
    end
end

return BlocksBuilder
