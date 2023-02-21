local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local icons = require("utils.icons")

nvim_tree.setup({
	hijack_directories = {
		enable = false,
	},
	disable_netrw = true,
	hijack_netrw = true,
	hijack_cursor = true,
	update_cwd = true,
	open_on_tab = false,
	-- quit_on_open = false,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore", "node_modules", ".git", ".cache" },
	},
	renderer = {
		add_trailing = false,
		group_empty = true,
		highlight_git = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│",
				none = "",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = icons.ui.ArrowOpen,
					arrow_closed = icons.ui.ArrowClosed,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "✗",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		-- width = 35,
		-- height = 10,
		hide_root_folder = true,
		side = "right",
		-- auto_resize = true,
		adaptive_size = true,
		mappings = {
			custom_only = false,
		},
		number = false,
		relativenumber = false,
	},
	log = {
		enable = true,
		truncate = true,
		types = {
			git = true,
			profile = true,
		},
	},
})
