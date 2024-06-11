local M = {}

M.ensure_installed = {
  "lua",
  "typescript",
  "javascript",
  "html",
  "css",
  "bash",
  "json",
  "json5",
  "tsx",
  "vue",
  "yaml",
  "markdown",
  "markdown_inline",
  "hurl",
  "gitignore",
  "dockerfile",
}

local opts = {
  ensure_installed = M.ensure_installed,
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = function(_, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = { enable = true, disable = { "python", "yaml" } },
  autotag = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
        ["ai"] = "@conditional.outer",
        ["ii"] = "@conditional.inner",
        ["ak"] = "@block.outer",
        ["ik"] = "@block.inner",
        ["as"] = "@statement.outer",
      },
    },
  },
}

function M.setup()
  local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end

  vim.filetype.add({
    extension = {
      hurl = "hurl",
    },
  })

  treesitter_configs.setup(opts)
  vim.g.skip_ts_context_commentstring_module = true
  require("ts_context_commentstring").setup({
    enable_autocmd = false,
  })
  local ts_utils = require("nvim-treesitter.ts_utils")
  ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
  ts_utils.get_node_range = vim.treesitter.get_node_range
end

return M
