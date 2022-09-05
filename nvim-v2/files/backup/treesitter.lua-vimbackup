local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup {
	ensure_installed = {
		"typescript",
		"javascript",
		"html",
		"css",
		"bash",
		"json",
		"scss",
		"tsx",
		"vue",
		"comment",
		"dockerfile",
		"graphql",
		"lua",
		"yaml",
	},
  sync_install = true,            -- install languages synchronously (only applied to `ensure_installed`)

	-- autotag = { enable = true },
  ignore_install = { "haskell" },  -- list of parsers to ignore installing
  highlight = {
    enable = true,
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = false,
    keymaps = {
      init_selection    = "<leader>gnn",
      node_incremental  = "<leader>gnr",
      scope_incremental = "<leader>gne",
      node_decremental  = "<leader>gnt",
    },
  },

  indent = {
    enable = true
  },

  rainbow = {
    enable = true,
    extended_mode = true,
 },

  context_commentstring = {
    enable = true,
    enable_autocmd = false,
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
				["as"] = "@statement.outer",
				["ai"] = "@conditional.outer",
				["ii"] = "@conditional.inner",
				["ak"] = "@block.inner",
				["ik"] = "@block.outer",
      },
    },
   -- swap = {
   --   enable = true,
   --   swap_next = {
   --     ["~"] = "@parameter.inner",
   --   },
   -- },
  },

 -- textsubjects = {
 --   enable = true,
 --   keymaps = {
 --     ['<cr>'] = 'textsubjects-smart', -- works in visual mode
 --   }
 -- },
}
