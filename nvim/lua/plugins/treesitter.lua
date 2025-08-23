return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    enabled = HVIM.plugins.treesitter,
    main = "nvim-treesitter.configs",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
      vim.filetype.add({
        extension = {
          hurl = "hurl",
        },
      })
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", event = { "VeryLazy" } },
    },
    keys = {
      { "@", "<cmd>Inspect<cr>", desc = "Treesitter Inspect" },
    },
    opts = {
      ensure_installed = {
        "lua",
        "typescript",
        "javascript",
        "html",
        "css",
        "tsx",
        "bash",
        "json",
        "vue",
        "yaml",
        "sql",
        -- "markdown",
        -- "markdown_inline",
        "hurl",
        "gitignore",
        "dockerfile",

        "jsdoc",
        "luadoc",

        -- "go",
        "go",
        "gomod",
        "gowork",
        "gosum",

        -- rust
        "rust",
        -- "ron",
      },
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
            ["ic"] = "@class.inner",
            ["ia"] = "@parameter.inner",
            ["aa"] = "@parameter.outer",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["as"] = "@statement.outer",
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "v",
            ["@class.outer"] = "<c-v>",
          },
        },
      },
      additional_vim_regex_highlighting = false,
    },
    opts_extend = { "ensure_installed" },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    enabled = false,
    opts = {},
  },
}
