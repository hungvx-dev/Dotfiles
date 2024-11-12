local M = {}

M.setup = function()
  -- Install treesitter-norg by: 'CC=$(which gcc-14) nvim -c ":TSInstallSync norg"'
  require("neorg").setup({
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            neorg = "~/Dev/Learning/neorg",
          },
          default_workspace = "neorg",
        },
      },
      ["core.export"] = {},
    },
  })

  vim.wo.conceallevel = 2
end

return M
