local present, tree_c = pcall(require, "nvim-tree.config")
if not present then
  return
end

local tree_cb = tree_c.nvim_tree_callback
local g = vim.g


g.nvim_tree_git_hl = 1
-- g.nvim_tree_indent_markers= 1


g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "★"
  },
  folder = {
    arrow_open = "",
    arrow_closed = "",
    default = "",
    empty = "", -- 
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = ""
  }
}

require 'nvim-tree' .setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = true,
  ignore_ft_on_setup = {},
  auto_close = false,
  open_on_tab = false,
  update_to_buf_dir = {
    enable = true,
    auto_open = true
  },
  hijack_cursor = true,
  update_cwd = false,
  update_cwd = false,

  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = ""
    }
  },
  files = {
    dotfiles = true,
    custom = { ".git", "node_modules", ".cache", ".DS_Store" }
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {}
  },
  system_open = {
    cmd = nil,
    args = {}
  },

  renderer = {
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
    },
  },
  view = {
    width = 30,
    height = 30,
    side = 'right',
    auto_resize = true,
    mappings = {
      custom_only = false,
      list = {}
    }
  },
  log = {
    enable = true,
    truncate = true,
    types = {
      git = true,
      profile = true,
    },
  },
}

require 'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- you can specify color or cterm_color instead of specifying both of them
  override = {
    -- DevIcon will be appended to `name`
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}
