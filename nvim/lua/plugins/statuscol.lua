return {
  {
    "statuscol",
    dev = true,
    event = "VimEnter",
    opts = {
      ft_ignore = { "neo-tree", "alpha", "lazy", "help" },
      wrap = { "markdown" },
    },
    config = function(_, opts)
      local id = vim.api.nvim_create_augroup("StatusCol", {})
      if opts.ft_ignore then
        vim.wo.statuscolumn = "%!v:lua.require('plugins.configs.dev.statuscol').statuscol()"

        if opts.ft_ignore then
          vim.api.nvim_create_autocmd("FileType", { group = id, pattern = opts.ft_ignore, command = "setlocal stc=" })
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
      end
      if opts.wrap then
        vim.api.nvim_create_autocmd(
          "FileType",
          { group = id, pattern = opts.wrap, command = "setlocal stc=%s%{v:relnum==0?v:lnum:v:relnum}%=" }
        )
        vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      end
    end,
  },
}
