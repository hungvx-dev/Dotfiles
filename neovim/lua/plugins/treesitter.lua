local M = {}

local opts = {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "help", "query",
    "typescript",
    "javascript",
    "html",
    "css", "scss",
    "bash",
    "json", "json5", "jsonc",
    "tsx",
    "vue",
    "regex",
    "comment",
    "dockerfile",
    "graphql",
    "yaml",
    "fish",
    "gitignore", "git_rebase",
    "markdown", "markdown_inline",
    "prisma", "toml"
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {  },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = { enable = true },
  indent = { enable = true, disable = { "python" } },
  context_commentstring = { enable = true, enable_autocmd = false },

  rainbow = {
    enable = true,
    extended_mode = true,
  },

  textobjects = {
    -- move = {
    --   enable = true,
    --   set_jumps = true, -- whether to set jumps in the jumplist
    --   goto_next_start = {
    --     ["]]"] = "@function.outer",
    --     ["]m"] = "@class.outer",
    --   },
    --   goto_next_end = {
    --     ["]["] = "@function.outer",
    --     ["]M"] = "@class.outer",
    --   },
    --   goto_previous_start = {
    --     ["[["] = "@function.outer",
    --     ["[m"] = "@class.outer",
    --   },
    --   goto_previous_end = {
    --     ["[]"] = "@function.outer",
    --     ["[M"] = "@class.outer",
    --   },
    -- },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
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

  treesitter_configs.setup(opts)
  -- handle deprecated API, https://github.com/windwp/nvim-autopairs/pull/324
  local ts_utils = require "nvim-treesitter.ts_utils"
  ts_utils.is_in_node_range = vim.treesitter.is_in_node_range
  ts_utils.get_node_range = vim.treesitter.get_node_range
end

return M
