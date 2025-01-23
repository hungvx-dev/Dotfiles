return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  enabled = HVIM.plugins.treesitter,
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  init = function()
    vim.filetype.add({
      extension = {
        hurl = "hurl",
      },
    })
  end,
  opts = {
    ensure_installed = {
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

      -- "go",
      "go",
      "gomod",
      "gowork",
      "gosum",
    },
    sync_install = true,
    auto_install = true,
    ignore_install = {},
    highlight = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "yaml" } },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25,       -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
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
  },
  config = function(_, opts)
    local treesitter_config = require("nvim-treesitter.configs")
    treesitter_config.setup(opts)
  end,
}
