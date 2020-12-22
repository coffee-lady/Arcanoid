return function(block)
    local scale = block.length / block.data.default_width

    block.scale = vmath.vector3(scale, scale, scale)
end
