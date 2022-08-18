local db = require("dashboard")
local home = os.getenv("HOME")

db.preview_command = "cat | lolcat -F 0.3"
db.preview_file_path = home .. "/.config/nvim/static/neovim.cat"
db.preview_file_height = 10
db.preview_file_width = 45
db.custom_center = {
	{
		icon = "  ",
		desc = "Recently latest session                 ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		action = "Telescope live_grep",
		shortcut = "SPC f w",
	},
	-- {
	-- 	icon = "  ",
	-- 	desc = "Open Personal dotfiles                  ",
	-- 	action = "Telescope dotfiles path=" .. home .. "/Dev/Dotfiles",
	-- 	shortcut = "SPC f d",
	-- },
	-- {
	-- 	icon = "  ",
	-- 	desc = "File Browser                            ",
	-- 	action = "Telescope file_browser",
	-- 	shortcut = "SPC f b",
	-- },
}

-- vim.g.dashboard_default_executive = "telescope"

-- vim.g.dashboard_custom_section = {
-- 	a = { description = { "   Find File                 SPC f f" }, command = "Telescope find_files" },
-- 	b = { description = { "   Recents                   SPC f o" }, command = "Telescope oldfiles" },
-- 	c = { description = { "   Find Word                 SPC f t" }, command = "Telescope live_grep" },
-- 	e = { description = { "   Last Session              SPC s l" }, command = "SessionLoad" },
-- }

-- local nmap = require("utils.keymaps").nmap
-- nmap("<leader>ss", ":<C-u>SessionSave<CR>")
-- nmap("<leader>sl", ":<C-u>SessionLoad<CR>")
