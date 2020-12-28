local ImagesController = {}

function ImagesController:set(data)
    gui.play_flipbook(data.node, data.animation)
end

function ImagesController:set_multiple(data)
    for i = 1, #data do
        local item = data[i]
        gui.play_flipbook(item.node, item.animation)
    end
end

return ImagesController
