local M = {}
-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
-- vim.fn.sign_define("DiagnosticSignError", { text = hvim.icons.Diagnostics.BoldError, texthl = "DiagnosticSignError" })
-- vim.fn.sign_define("DiagnosticSignWarn", { text = hvim.icons.Diagnostics.BoldWarning, texthl = "DiagnosticSignWarn" })
-- vim.fn.sign_define(
--   "DiagnosticSignInfo",
--   { text = hvim.icons.Diagnostics.BoldInformation, texthl = "DiagnosticSignInfo" }
-- )
-- vim.fn.sign_define("DiagnosticSignHint", { text = hvim.icons.Diagnostics.BoldHint, texthl = "DiagnosticSignHint" })

-- in the form "LspDiagnosticsSignWarning"
local setup = {
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  default_component_configs = {
    container = {
      enable_character_fade = true,
    },
    indent = {
      indent_size = 2,
      padding = 1, -- extra padding on left hand side
      -- indent guides
      with_markers = true,
      with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      -- expander config, needed for nesting files
      expander_collapsed = hvim.icons.UI.Direction.Angle.Right,
      expander_expanded = hvim.icons.UI.Direction.Angle.Down,
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = hvim.icons.UI.Folder.Icon,
      folder_open = hvim.icons.UI.Folder.Open,
      folder_empty = hvim.icons.UI.Folder.Empty,
      folder_empty_open = hvim.icons.UI.Folder.EmptyOpen,
      -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
      -- then these will never be used.
      default = "*",
      highlight = "NeoTreeFileIcon",
    },
    modified = {
      symbol = "[+]",
      highlight = "NeoTreeModified",
    },
    name = {
      trailing_slash = false,
      use_git_status_colors = true,
      highlight = "NeoTreeFileName",
    },
    git_status = {
      symbols = {
        -- Change type
        added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
        deleted = hvim.icons.Git.LineRemoved, -- this can only be used in the git_status source
        renamed = hvim.icons.Git.LineRename, -- this can only be used in the git_status source
        -- Status type
        untracked = hvim.icons.Git.FileUntracked,
        ignored = hvim.icons.Git.FileIgnored,
        unstaged = hvim.icons.Git.FileUnstaged,
        staged = hvim.icons.Git.FileStaged,
        conflict = hvim.icons.Git.FileUnmerged,
      },
    },
  },
  window = {
    position = "right",
    width = 40,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ["<space>"] = "none",
      ["o"] = "open_with_window_picker",
      ["<C-x>"] = "split_with_window_picker",
      ["<C-v>"] = "vsplit_with_window_picker",
    },
  },
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    -- hijack_netrw_behavior = "open_current"
    -- hijack_netrw_behavior = "disabled",
    use_libuv_file_watcher = true,
  },
  buffers = {
    follow_current_file = true, -- This will find and focus the file in the active buffer every
    -- time the current file is changed while the tree is open.
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
  },
}

function M.setup()
  local status_ok, neo_tree = pcall(require, "neo-tree")
  if not status_ok then
    return
  end

  neo_tree.setup(setup)
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit",
    callback = function()
      if package.loaded["neo-tree.sources.git_status"] then
        require("neo-tree.sources.git_status").refresh()
      end
    end,
  })
  vim.keymap.set("n", "<leader>n", ":NeoTreeFocus<cr>")
end

return M