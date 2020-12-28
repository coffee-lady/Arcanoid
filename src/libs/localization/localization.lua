local LocalizationLib = {}

function LocalizationLib:update(data, id)
    local node = gui.get_node(id)
    local text = data[id]
    gui.set_text(node, text)
end

return LocalizationLib
