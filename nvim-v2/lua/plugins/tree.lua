local utils = require("utils")
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end
local icons = require("icons")

local TREE_WIDTH = 40

local git_icons = {
	unstaged = "",
	staged = "",
	unmerged = "",
	renamed = "➜",
	untracked = "",
	deleted = "",
	ignored = "◌",
}

local keymappings = {
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	-- <C-e> keymapping cannot be set because it's used for toggling nvim-tree
	{ key = "<C-e>", action = "edit_in_place" },
	{ key = { "O" }, action = "edit_no_picker" },
	{ key = { "<2-RightMouse>", "<C-]>" }, action = "cd" },
	{ key = "<C-v>", action = "vsplit" },
	{ key = "<C-x>", action = "split" },
	{ key = "<C-t>", action = "close" },
	{ key = "<", action = "prev_sibling" },
	{ key = ">", action = "next_sibling" },
	{ key = "P", action = "parent_node" },
	{ key = "<BS>", action = "close_node" },
	-- { key = "<Tab>", action = "preview" },
	-- { key = "K", action = "first_sibling" },
	-- { key = "J", action = "last_sibling" },
	-- { key = "I", action = "toggle_ignored" },
	-- { key = "H", action = "toggle_dotfiles" },
	{ key = "R", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "D", action = "trash" },
	{ key = "r", action = "rename" },
	{ key = "<C-r>", action = "full_rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
	{ key = "y", action = "copy_name" },
	{ key = "Y", action = "copy_path" },
	{ key = "gy", action = "copy_absolute_path" },
	{ key = "[c", action = "prev_git_item" },
	{ key = "]c", action = "next_git_item" },
	{ key = "-", action = "dir_up" },
	{ key = "s", action = "system_open" },
	{ key = "q", action = "close" },
	{ key = "g?", action = "toggle_help" },
	{ key = "W", action = "collapse_all" },
	{ key = "S", action = "search_node" },
}

nvim_tree.setup({
	disable_netrw = true, -- disables netrw completely
	hijack_netrw = true, -- hijack netrw window on startup
	open_on_setup = false, -- hijack netrw window on startup
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},
	open_on_tab = false, -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	hijack_cursor = true, -- hijack the cursor in the tree to put it at the start of the filename
	update_cwd = true, -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	hijack_unnamed_buffer_when_opening = false, -- opens in place of the unnamed buffer if it's empty
	respect_buf_cwd = true, --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore", "node_modules", ".git", ".cache" },
	},
	diagnostics = { -- show lsp diagnostics in the signcolumn
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	renderer = {
		add_trailing = false,
		group_empty = true,
		highlight_git = true,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
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
					-- arrow_open = "",
					-- arrow_closed = "",
					arrow_open = icons.chevronOpen,
					arrow_closed = icons.chevronRight,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = git_icons,
			},
		},
	},
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		enable = true, -- enables the feature
		update_cwd = true,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {},
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd = "",
		-- the command arguments as a list
		args = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	actions = {
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
			restrict_above_cwd = false,
		},
		open_file = {
			quit_on_open = false,
			-- if true the tree will resize itself after opening a file
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	view = {
		width = TREE_WIDTH,
		hide_root_folder = true,
		side = "right",
		adaptive_size = true,
		number = false,
		relativenumber = false,
		signcolumn = "yes",
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = true,
			-- list of mappings to set on the tree manually
			list = keymappings,
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	-- log                                = {
	--   enable = false,
	--   truncate = true,
	--   types = {
	--     git = true,
	--     profile = true,
	--   },
	-- },
})

vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>lua require'nvim-tree'.toggle()<CR>", { noremap = true, silent = true })

-- local nvim_tree_events = require('nvim-tree.events')
-- local bufferline_api = require('bufferline.api')
--
-- local function get_tree_size()
--   return require 'nvim-tree.view'.View.width
-- end

-- bufferline_api.set_offset(40)
-- nvim_tree_events.subscribe('TreeOpen', function()
-- bufferline_api.set_offset(40)
-- end)

-- nvim_tree_events.subscribe('Resize', function()
--   bufferline_api.set_offset(get_tree_size())
-- end)
--
-- nvim_tree_events.subscribe('TreeClose', function()
--   bufferline_api.set_offset(0)
-- end)
