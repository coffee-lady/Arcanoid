local richtext = require('richtext.richtext')
local Libs = require('src.libs.libs')

local class = Libs.middleclass
local Array = Libs.array

--- @class RichTextNode
--- @field text_metrics table
local RichTextNode = class('RichTextNode')

RichTextNode.ALIGN_LEFT = richtext.ALIGN_LEFT
RichTextNode.ALIGN_CENTER = richtext.ALIGN_CENTER
RichTextNode.ALIGN_RIGHT = richtext.ALIGN_RIGHT
RichTextNode.ALIGN_JUSTIFY = richtext.ALIGN_JUSTIFY

RichTextNode.VALIGN_TOP = richtext.VALIGN_TOP
RichTextNode.VALIGN_MIDDLE = richtext.VALIGN_MIDDLE
RichTextNode.VALIGN_BOTTOM = richtext.VALIGN_BOTTOM

function RichTextNode:initialize(text, settings)
    -- local settings = {
    --     fonts = {
    --         Roboto = {
    --             regular = hash("Roboto-Regular"),
    --             italic = hash("Roboto-Italic"),
    --             bold = hash("Roboto-Bold"),
    --             bold_italic = hash("Roboto-BoldItalic"),
    --         },
    --         Nanum = {
    --             regular = hash("Nanum-Regular"),
    --         },
    --     },
    --     initial_font = "Roboto",
    --     width = 400,
    --     parent = gui.get_node("bg"),
    --     color = vmath.vector4(0.95, 0.95, 1.0, 1.0),
    --     shadow = vmath.vector4(0.0, 0.0, 0.0, 1.0),
    --     -- align (hash) - One of richtext.ALIGN_LEFT, richtext.ALIGN_CENTER, richtext.ALIGN_RIGHT and richtext.ALIGN_JUSTIFY.
    -- }

    settings = Array.copy_1d(settings)
    settings.parent = settings.parent.target
    -- local text =
    -- "<size=3><outline=green><RichText</outline></size>Lorem <color=0,0.5,0,1>ipsum </color><img=smileys:zombie/> dolor <color=red>sit </color><color=#ff00ffff>amet, </color><size=1.15><font=Nanum>consectetur </font></size>adipiscing elit. <b>Nunc </b>tincidunt <b><i>mattis</i> libero</b> <i>non viverra</i>.\n\nNullam ornare <img=smileys:hungry/>accumsan rhoncus.\n\nNunc placerat nibh a purus auctor, id scelerisque massa <size=2>rutrum.</size>"

    self.nodes, self.text_metrics = richtext.create(text, settings.initial_font, settings)
    self.target = settings.parent
end

function RichTextNode:get_actual_size()
    return self.text_metrics
end

function RichTextNode:get_metrics()
    return self.text_metrics
end

return RichTextNode
