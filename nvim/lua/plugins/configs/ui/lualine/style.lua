local components = require("plugins.configs.ui.lualine.components")

local style = {
  options = {
    theme = "tokyonight",
    globalstatus = true,
    icons_enabled = HVIM.use_icons,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {
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
      -- components.filename,
    },
    lualine_x = {
      components.lazy,
      components.lsp,
      -- components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = { components.progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { components.filename },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "fzf",
    "neo-tree",
    "lazy",
  },
}

return style
