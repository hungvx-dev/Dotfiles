local colors = {}

local darkGruvbox = {
    white = "#abb2bf",
    darker_black = "#fff",
    black = "#1e222a", --  nvim bg
    active_tab_bg = "#3D4E42",
    black2 = "#252931",
    one_bg = "#282c34", -- real bg of onedark
    one_bg2 = "#353b45",
    one_bg3 = "#30343c",
    grey = "#42464e",
    grey_fg = "#565c64",
    grey_fg2 = "#6f737b",
    light_grey = "#6f737b",
    red = "#d47d85",
    baby_pink = "#DE8C92",
    pink = "#ff75a0",
    line = "#7eca9c", -- for lines like vertsplit
    indentBlankline = "#6f737b", -- Intdent lines color
    green = "#A3BE8C",
    vibrant_green = "#7eca9c",
    nord_blue = "#81A1C1",
    blue = "#61afef",
    yellow = "#e7c787",
    sun = "#EBCB8B",
    purple = "#b4bbc8",
    dark_purple = "#c882e7",
    teal = "#519ABA",
    orange = "#fca2aa",
    cyan = "#a3b8ef",
    statusline_bg = "#22262e",
    lightbg = "#2d3139",
    lightbg2 = "#262a32"
}

local lightGruvbox = {
    white = "#abb2bf",
    darker_black = "#fff",
    black = "#1e222a", --  nvim bg
    active_tab_bg = "#b57614",
    black2 = "#252931",
    one_bg = "#EBCB8B", -- real bg of onedark / auto complation, whichkey.
    one_bg2 = "#353b45",
    one_bg3 = "#30343c",
    grey = "#42464e",
    grey_fg = "#565c64",
    grey_fg2 = "#6f737b",
    light_grey = "#6f737b",
    red = "#9d0006",
    baby_pink = "#DE8C92",
    pink = "#ff75a0",
    line = "#7eca9c", -- for lines like vertsplit
    indentBlankline = "#6f737b", -- Intdent lines color
    green = "#A3BE8C",
    vibrant_green = "#7eca9c",
    nord_blue = "#076678",
    blue = "#61afef",
    yellow = "#b57614",
    sun = "#EBCB8B",
    purple = "#b16286",
    dark_purple = "#c882e7",
    teal = "#519ABA",
    orange = "#fca2aa",
    cyan = "#a3b8ef",
    statusline_bg = "#dfc4a1",
    lightbg = "#7c6f64", -- statusline right.
    lightbg2 = "#af3a03" --- statusline left.
}


if O.colorscheme == 'gruvbox'
then
    if O.background == 'dark' 
    then
        colors = darkGruvbox     
    else 
        colors = lightGruvbox
    end
else 
    colors = darkGruvbox     
end

return colors
