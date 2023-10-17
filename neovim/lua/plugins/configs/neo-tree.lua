local M = {}
-- Unless you are still migrating, remove the deprecated commands from v1.x
-- vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

local setup = {
  sources = { "filesystem", "buffers", "git_status", "document_symbols" },
  open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
  close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = true,
  default_component_configs = {
    indent = {
      expander_collapsed = hvim.icons.UI.Direction.Angle.Right,
      expander_expanded = hvim.icons.UI.Direction.Angle.Down,
    },
    icon = {
      folder_closed = hvim.icons.UI.Folder.Icon,
      folder_open = hvim.icons.UI.Folder.Open,
      folder_empty = hvim.icons.UI.Folder.Empty,
      folder_empty_open = hvim.icons.UI.Folder.EmptyOpen,
    },
    modified = {
      symbol = hvim.icons.Git.LineModified,
    },
    git_status = {
      symbols = {
        -- Change type
        added = hvim.icons.Git.LineAdded, -- or "✚", but this is redundant info if you use git_status_colors on the name
        modified = hvim.icons.Git.LineModified, -- or "", but this is redundant info if you use git_status_colors on the name
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
  filesystem = {
    follow_current_file = { enabled = true, leave_dirs_open = true },
    use_libuv_file_watcher = true,
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
  window = {
    position = "right",
    width = 40,
    mappings = {
      ["<space>"] = "none",
      ["o"] = "open_with_window_picker",
      ["<C-x>"] = "split_with_window_picker",
      ["<C-v>"] = "vsplit_with_window_picker",
      ["Y"] = "copy_selector_path",
    },
  },
  buffers = {
    follow_current_file = {
      enabled = true, -- This will find and focus the file in the active buffer every time
      --              -- the current file is changed while the tree is open.
      leave_dirs_open = true, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
    },
    group_empty_dirs = true, -- when true, empty folders will be grouped together
    show_unloaded = true,
    -- window = {
    --   mappings = {
    --     ["<leader>bd"] = "buffer_delete",
    --   },
    -- },
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

  vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
end

return M
