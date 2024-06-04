local M = {}
M.opts = {
  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
  close_if_last_window = false,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  nesting_rules = {
    [""] = { "" },
  },
  default_component_configs = {
    indent = {
      with_expanders = nil,
      expander_collapsed = HVIM.icons.UI.Direction.Angle.Right,
      expander_expanded = HVIM.icons.UI.Direction.Angle.Down,
    },
    icon = {
      folder_closed = HVIM.icons.UI.Folder.Close,
      folder_open = HVIM.icons.UI.Folder.Open,
      folder_empty = HVIM.icons.UI.Folder.Empty,
      folder_empty_open = HVIM.icons.UI.Folder.EmptyOpen,
    },
    modified = {
      symbol = HVIM.icons.Git.LineModified,
    },
    diagnostics = {
      symbols = {
        hint = HVIM.signs.Hint,
        info = HVIM.signs.Info,
        warn = HVIM.signs.Warn,
        error = HVIM.signs.Error,
      },
    },
    git_status = {
      symbols = {
        -- Change type
        added = HVIM.icons.Git.LineAdded,
        modified = HVIM.icons.Git.LineModified,
        deleted = HVIM.icons.Git.LineRemoved,
        renamed = HVIM.icons.Git.LineRename,
        -- Status type
        untracked = HVIM.icons.Git.FileUntracked,
        ignored = HVIM.icons.Git.FileIgnored,
        unstaged = HVIM.icons.Git.FileUnstaged,
        staged = HVIM.icons.Git.FileStaged,
        conflict = HVIM.icons.Git.FileConflict,
      },
    },
  },
  commands = {
    copy_selector_path = function(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify

      local vals = {
        ["1"] = modify(filepath, ":."),
        ["2"] = filename,
        ["3"] = modify(filepath, ":~"),
        ["4"] = filepath,
      }

      local options = vim.tbl_filter(function(val)
        return vals[val] ~= ""
      end, vim.tbl_keys(vals))
      if vim.tbl_isempty(options) then
        vim.notify("No values to copy", vim.log.levels.WARN)
        return
      end
      table.sort(options)
      vim.ui.select(options, {
        prompt = "Choose to copy to clipboard:",
        format_item = function(item)
          return ("%s: %s"):format(item, vals[item])
        end,
      }, function(choice)
        local result = vals[choice]
        if result then
          vim.notify(("Copied: `%s`"):format(result))
          vim.fn.setreg("+", result)
        end
      end)
    end,
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    group_empty_dirs = false,
    use_libuv_file_watcher = true,
    filtered_items = {
      never_show = {
        ".DS_Store",
      },
    },
    window = {
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        -- ["<space>"] = "none",
        ["A"] = "command_b",
        ["Y"] = "copy_selector_path",
        ["<C-x>"] = "split_with_window_picker",
        ["<C-v>"] = "vsplit_with_window_picker",
        ["o"] = { "open", nowait = true },
      },
    },
    fuzzy_finder_mappings = {
      ["<C-j>"] = "move_cursor_down",
      ["<C-k>"] = "move_cursor_up",
    },
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    group_empty_dirs = false,
    show_unloaded = true,
    window = {
      mappings = {
        ["."] = "set_root",
        ["<bs>"] = "navigate_up",
      },
    },
  },
  window = {
    position = "right",
    width = 40,
    mappings = {},
  },
}

function M.setup()
  local status_ok, neo_tree = pcall(require, "neo-tree")
  if not status_ok then
    return
  end

  neo_tree.setup(M.opts)
  vim.api.nvim_create_autocmd("TermClose", {
    pattern = "*lazygit",
    callback = function()
      if package.loaded["neo-tree.sources.git_status"] then
        require("neo-tree.sources.git_status").refresh()
      end
    end,
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "neo-tree" },
    callback = function()
      require("ufo").detach()
      vim.opt_local.foldenable = false
    end,
  })

  vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
end

return M
