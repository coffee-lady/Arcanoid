local BlockView = {}

function BlockView:create(block)
    local id = factory.create(msg.url('/game_scene#factory'), block.pos, nil, nil, block.scale)
    go.set(msg.url('game_scene', id, 'sprite'), 'tint', block.color)

    return id
end

function BlockView:rebuild(block)
    go.set_position(block.pos, block.id)
    go.set_scale(block.scale, block.id)
end

function BlockView:set_sprite_color(color)
    go.set('#sprite', 'tint', color)
end

return BlockView