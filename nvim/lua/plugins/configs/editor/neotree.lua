local M = {}

M.keys = {
  { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree toggle" },
  { "<leader>n", "<cmd>Neotree focus<cr>", desc = "NeoTree focus" },
}

function M.init()
  if vim.fn.argc() == 1 then
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == "directory" then
      require("neo-tree")
    end
  end
end

function M.deactivate()
  vim.cmd([[Neotree close]])
end

function M.opts()
  local mini_icons = require("mini.icons")

  return {
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

          if text then
            icon.text = text
          end
          if hl then
            icon.highlight = hl
          end
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
          -- ["A"] = "command_b",
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
end
function M.setup()
  local neo_tree = require("neo-tree")

  neo_tree.setup(M.opts())
end

return M
