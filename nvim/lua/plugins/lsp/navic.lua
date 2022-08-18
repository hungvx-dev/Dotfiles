local status_ok, navic = pcall(require, "nvim-navic")
if not status_ok then
	return
end

local icons = require("plugins.icons")
navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
  separator = " " .. icons.ui.ChevronRight .. " ",
	depth_limit = 0,
	depth_limit_indicator = "..",
})

vim.o.statusline = "%{%v:lua.require'nvim-navic'.get_location()%}"
-- vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- navic.setup {
--   icons = {
--     File = ' ',
--     Module = ' ',
--     Namespace = ' ',
--     Package = ' ',
--     Class = ' ',
--     Method = ' ',
--     Property = ' ',
--     Field = ' ',
--     Constructor = ' ',
--     Enum = ' ',
--     Interface = ' ',
--     Function = ' ',
--     Variable = ' ',
--     Constant = ' ',
--     String = ' ',
--     Number = ' ',
--     Boolean = ' ',
--     Array = ' ',
--     Object = ' ',
--     Key = ' ',
--     Null = ' ',
--     EnumMember = ' ',
--     Struct = ' ',
--     Event = ' ',
--     Operator = ' ',
--     TypeParameter = ' '
--   }
-- }
