local CoordsLib = {}

function CoordsLib.is_point_in_segment(point, start_coord, end_coord)
    return point >= start_coord and point <= end_coord or point <= start_coord and point >= end_coord
end

function CoordsLib.vlength(start_coords, end_coords)
    local dx = start_coords.x - end_coords.x
    local dy = start_coords.y - end_coords.y
    return math.sqrt(dx * dx + dy * dy)
end

function CoordsLib.hypotenuse(x, y)
    return math.sqrt(x * x + y * y)
end

return CoordsLib
