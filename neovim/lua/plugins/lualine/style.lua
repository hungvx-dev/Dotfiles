local components = require "plugins.lualine.components"

local style = {
  options = {
    theme = "tokyonight",
    globalstatus = true,
    icons_enabled = hvim.use_icons,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Outline", "dashboard", "fugitive", "gitcommit", "NvimTree" },
    ignore_focus = {
      "NvimTree",
      "packer",
      "toggleterm",
      "dapui_scopes",
      "dapui_stacks",
      "dapui_breakpoints",
      "dapui_watches",
      "dap-repl",
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
      components.spaces,
      components.filetype,
    },
    lualine_y = { components.location },
    lualine_z = { components.progress, },
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
    "aerial",
    "chadtree",
    "fern",
    "fugitive",
    "fzf",
    "man",
    "mundo",
    "neo-tree",
    "lazy",
    "nerdtree",
    "nvim-dap-ui",
    "nvim-tree",
    "symbols-outline",
    "toggleterm",
  },
}

return style
