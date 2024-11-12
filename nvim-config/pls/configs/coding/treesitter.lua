local M = {}

M.ensure_installed = {
  "lua",
  "typescript",
  "javascript",
  "jsdoc",
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

M.opts = {
  ensure_installed = M.ensure_installed,
  sync_install = true,
  auto_install = true,
  ignore_install = {},
  highlight = {
    enable = true,
  },
  indent = { enable = true, disable = { "python", "yaml" } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>ss",
      node_incremental = "<leader>si",
      scope_incremental = "<Leader>sc",
      node_decremental = "<leader>sd",
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
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "v",
        ["@class.outer"] = "<c-v>",
      },
    },
  },
}

M.init = function()
  vim.filetype.add({
    extension = {
      hurl = "hurl",
    },
  })
end

M.autotag = {
  opts = {
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false, -- Auto close on trailing </
  },
}

function M.setup(_, opts)
  local treesitter_config = require("nvim-treesitter.configs")
  treesitter_config.setup(opts)
end

return M
