local components = require("plugins.configs.ui.lualine.components")

local M = {}

M.init = function()
  if vim.fn.argc(-1) > 0 then
    vim.o.statusline = " "
  else
    vim.o.laststatus = 0
  end
end


M.opts = {
  options = {
    theme = "auto",
    globalstatus = true,
    icons_enabled = HVIM.use_icons,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {
        "ministarter",
        "help",
        "dashboard",
        "alpha",
        "TelescopePrompt",
      },
    },
  },
  sections = {
    lualine_a = {
      components.mode,
      components.branch,
    },
    lualine_b = {
      components.diagnostics,
    },
    lualine_c = {
      components.diff,
    },
    lualine_x = {
      components.maximized,
      components.searchcount,
      components.lsp,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = { components.progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { components.filename },
    lualine_x = { components.filetype },
    lualine_y = {},
    lualine_z = {},
  },
  extensions = {
    "fzf",
    "neo-tree",
    "lazy",
  },
}

return M
