return {
  {
    "statuscol",
    dev = true,
    event = { "VeryLazy" },
    opts = {
      ft_ignore = { "neo-tree", "alpha", "lazy", "help" },
      -- bt_ignore = { "terminal" },
    },
    config = function(_, opts)
      vim.wo.statuscolumn = "%!v:lua.require('plugins.configs.statuscol').myStatusColumn()"
      local id = vim.api.nvim_create_augroup("StatusCol", {})
      if opts.ft_ignore then
        vim.api.nvim_create_autocmd("FileType", { group = id, pattern = opts.ft_ignore, command = "setlocal stc=;" })
        vim.api.nvim_create_autocmd("BufWinEnter", {
          group = id,
          callback = function()
            if vim.tbl_contains(opts.ft_ignore, vim.api.nvim_get_option_value("ft", { scope = "local" })) then
              vim.api.nvim_set_option_value("stc", "", { scope = "local" })
              vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
            end
          end,
        })
      end
      -- if opts.bt_ignore then
      --   vim.api.nvim_create_autocmd("OptionSet", {
      --     group = id,
      --     pattern = "buftype",
      --     callback = function()
      --       if vim.tbl_contains(opts.bt_ignore, vim.v.option_new) then
      --         vim.api.nvim_set_option_value("stc", "", { scope = "local" })
      --         vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      --       end
      --     end,
      --   })
      --   vim.api.nvim_create_autocmd("BufWinEnter", {
      --     group = id,
      --     callback = function()
      --       if vim.tbl_contains(opts.bt_ignore, vim.api.nvim_get_option_value("bt", { scope = "local" })) then
      --         vim.api.nvim_set_option_value("stc", "", { scope = "local" })
      --         vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      --       end
      --     end,
      --   })
      -- end
    end,
  },
}
