local M = {}

M.keys = {
  { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
  { "<leader>n", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
}

function M.init()
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
    desc = "Start Neo-tree with directory",
    once = true,
    callback = function()
      if package.loaded["neo-tree"] then
        return
      else
        local stats = vim.uv.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
          require("neo-tree")
        end
      end
    end,
  })
end

function M.deactivate()
  vim.cmd([[Neotree close]])
end

function M.opts()
  local mini_icons = require("mini.icons")

  return {
    sources = { "filesystem", "buffers", "git_status" },
    open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
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
        expander_collapsed = HVIM.icons.UI.Direction.MD.Right,
        expander_expanded = HVIM.icons.UI.Direction.MD.Down,
      },
      icon = {
        folder_closed = HVIM.icons.UI.Folder.Close,
        folder_open = HVIM.icons.UI.Folder.Open,
        folder_empty = HVIM.icons.UI.Folder.Empty,
        folder_empty_open = HVIM.icons.UI.Folder.EmptyOpen,
        provider = function(icon, node)
          local text, hl
          if node.type == "file" then
            text, hl = mini_icons.get("file", node.name)
          elseif node.type == "directory" then
            text, hl = mini_icons.get("directory", node.name)
            if node:is_expanded() then
              text = nil
            end
          end

          icon.text = text or icon.text
          icon.highlight = hl or icon.highlight
        end,
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
      file_size = {
        enabled = false,
      },
    },
    commands = {
      copy_selector_path = function(state)
        local node = state.tree:get_node()
        local filepath = node:get_id()
        local filename = node.name
        local modify = vim.fn.fnamemodify

        local results = {
          { val = modify(filename, ":r"), msg = "Filename no extension:" },
          { val = modify(filepath, ":."), msg = "Relative To CWD:" },
          { val = modify(filepath, ":~"), msg = "Relative To Home:" },
          { val = modify(filename, ":e"), msg = "Extension:" },
          { val = filepath, msg = "Absolute path:" },
          { val = filename, msg = "Filename:" },
        }

        local options = {}
        for i, item in ipairs(results) do
          table.insert(options, ("%d: %s"):format(i, item.val))
        end
        vim.ui.select(options, {
          prompt = "Choose to copy to clipboard:",
          format_item = function(item)
            return item
          end,
        }, function(_, idx)
          if idx then
            local item = results[idx]
            vim.notify(("Copied: %s"):format(item.val))
            vim.fn.setreg("+", item.val)
          end
        end)
      end,
    },
    filesystem = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true,
        leave_dirs_open = true,
      },
      use_libuv_file_watcher = true,
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
      width = 35,
      max_width = 50,
      mappings = {
        -- ["<space>"] = "none",
        -- ["A"] = "command_b",
        ["Y"] = "copy_selector_path",
        ["<C-x>"] = "split_with_window_picker",
        ["<C-v>"] = "vsplit_with_window_picker",
        ["o"] = { "open", nowait = true },
      },
    },
  }
end

return M
