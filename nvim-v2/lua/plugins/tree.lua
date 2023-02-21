local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end
-- local nvim_tree_events = require("nvim-tree.events")
-- local bufferline_api = require("bufferline.api")
local icons = require("utils.icons")

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
    { key = "<C-e>",                          action = "edit_in_place" },
    { key = { "O" },                          action = "edit_no_picker" },
    { key = { "<2-RightMouse>", "<C-]>" },    action = "cd" },
    { key = "<C-v>",                          action = "vsplit" },
    { key = "<C-x>",                          action = "split" },
    { key = "<C-t>",                          action = "close" },
    { key = "<",                              action = "prev_sibling" },
    { key = ">",                              action = "next_sibling" },
    { key = "P",                              action = "parent_node" },
    { key = "<BS>",                           action = "close_node" },
    -- { key = "<Tab>", action = "preview" },
    -- { key = "K", action = "first_sibling" },
    -- { key = "J", action = "last_sibling" },
    -- { key = "I", action = "toggle_ignored" },
    -- { key = "H", action = "toggle_dotfiles" },
    { key = "R",                              action = "refresh" },
    { key = "a",                              action = "create" },
    { key = "d",                              action = "remove" },
    { key = "D",                              action = "trash" },
    { key = "r",                              action = "rename" },
    { key = "<C-r>",                          action = "full_rename" },
    { key = "x",                              action = "cut" },
    { key = "c",                              action = "copy" },
    { key = "p",                              action = "paste" },
    { key = "y",                              action = "copy_name" },
    { key = "Y",                              action = "copy_path" },
    { key = "gy",                             action = "copy_absolute_path" },
    { key = "[c",                             action = "prev_git_item" },
    { key = "]c",                             action = "next_git_item" },
    { key = "-",                              action = "dir_up" },
    { key = "s",                              action = "system_open" },
    { key = "q",                              action = "close" },
    { key = "g?",                             action = "toggle_help" },
    { key = "W",                              action = "collapse_all" },
    { key = "S",                              action = "search_node" },
}

local nvimtree = {
    active = true,
    on_config_done = nil,
    setup = {
        auto_reload_on_write = false,
        disable_netrw = false,
        hijack_cursor = false,
        hijack_netrw = true,
        hijack_unnamed_buffer_when_opening = false,
        ignore_buffer_on_setup = false,
        sort_by = "name",
        root_dirs = {},
        prefer_startup_root = false,
        sync_root_with_cwd = true,
        reload_on_bufenter = false,
        respect_buf_cwd = false,
        on_attach = "disable",
        remove_keymaps = false,
        select_prompts = false,
        view = {
            adaptive_size = false,
            centralize_selection = false,
            width = TREE_WIDTH,
            hide_root_folder = false,
            side = "right",
            preserve_window_proportions = false,
            number = false,
            relativenumber = false,
            signcolumn = "yes",
            mappings = {
                custom_only = false,
                list = keymappings,
            },
            float = {
                enable = false,
                quit_on_focus_loss = true,
                open_win_config = {
                    relative = "editor",
                    border = "rounded",
                    width = 30,
                    height = 30,
                    row = 1,
                    col = 1,
                },
            },
        },
        renderer = {
            add_trailing = false,
            group_empty = false,
            highlight_git = true,
            full_name = false,
            highlight_opened_files = "none",
            root_folder_label = ":t",
            indent_width = 2,
            indent_markers = {
                enable = false,
                inline_arrows = true,
                icons = {
                    corner = "└",
                    edge = "│",
                    item = "│",
                    none = " ",
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
            special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
            symlink_destination = true,
        },
        hijack_directories = {
            enable = false,
            auto_open = true,
        },
        update_focused_file = {
            enable = true,
            debounce_delay = 15,
            update_root = true,
            ignore_list = {},
        },
        diagnostics = {
            enable = true,
            icons = {
                hint = "",
                info = "",
                warning = "",
                error = "",
            },
            show_on_dirs = false,
            show_on_open_dirs = true,
            debounce_delay = 50,
            severity = {
                min = vim.diagnostic.severity.HINT,
                max = vim.diagnostic.severity.ERROR,
            },
        },

        filters = {
            dotfiles = false,
            git_clean = false,
            no_buffer = false,
            custom = { "node_modules", "\\.cache" },
            exclude = {},
        },
        filesystem_watchers = {
            enable = true,
            debounce_delay = 50,
            ignore_dirs = {},
        },
        git = {
            enable = true,
            ignore = false,
            show_on_dirs = true,
            show_on_open_dirs = true,
            timeout = 200,
        },
        actions = {
            use_system_clipboard = true,
            change_dir = {
                enable = true,
                global = false,
                restrict_above_cwd = false,
            },
            expand_all = {
                max_folder_discovery = 300,
                exclude = {},
            },
            file_popup = {
                open_win_config = {
                    col = 1,
                    row = 1,
                    relative = "cursor",
                    border = "shadow",
                    style = "minimal",
                },
            },
            open_file = {
                quit_on_open = false,
                resize_window = false,
                window_picker = {
                    enable = true,
                    picker = "default",
                    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
                    exclude = {
                        filetype = { "notify", "lazy", "qf", "diff", "fugitive", "fugitiveblame" },
                        buftype = { "nofile", "terminal", "help" },
                    },
                },
            },
            remove_file = {
                close_window = true,
            },
        },
        trash = {
            cmd = "trash",
            require_confirm = true,
        },
        live_filter = {
            prefix = "[FILTER]: ",
            always_show_folders = true,
        },
        tab = {
            sync = {
                open = false,
                close = false,
                ignore = {},
            },
        },
        notify = {
            threshold = vim.log.levels.INFO,
        },
        log = {
            enable = false,
            truncate = false,
            types = {
                all = false,
                config = false,
                copy_paste = false,
                dev = false,
                diagnostics = false,
                git = false,
                profile = false,
                watcher = false,
            },
        },
        system_open = {
            cmd = nil,
            args = {},
        },
    },
}
nvim_tree.setup(nvimtree.setup)

vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>lua require'nvim-tree'.toggle()<CR>", { noremap = true, silent = true })

-- nvim_tree_events.on_tree_open(function()
-- 	bufferline_api.set_offset(TREE_WIDTH + 1, utils.add_whitespaces(13) .. "File Explorer")
-- end)
--
-- nvim_tree_events.on_tree_close(function()
-- 	bufferline_api.set_offset(0)
-- end)

