local colors = require("tokyonight.colors").setup()
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local status_theme_ok, theme = pcall(require, "lualine.themes.palenight")
if not status_theme_ok then
  return
end

local status_icons_ok, icons = pcall(require, "utils.icons")
if not status_icons_ok then
  return
end

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = true })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D4D4D4", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "#252525" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
local mode_color = {
  n = "#569cd6",
  i = "#6a9955",
  v = "#c586c0",
  [""] = "#c586c0",
  V = "#c586c0",
  c = "#4EC9B0",
  no = "#569cd6",
  s = "#ce9178",
  S = "#ce9178",
  [""] = "#ce9178",
  ic = "#dcdcaa",
  R = "#d16969",
  Rv = "#d16969",
  cv = "#569cd6",
  ce = "#569cd6",
  r = "#d16969",
  rm = "#4EC9B0",
  ["r?"] = "#4EC9B0",
  ["!"] = "#4EC9B0",
  t = "#D7BA7D",
}

local mode = {
  function()
    return "▊"
  end,
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = 0,
}

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = icons.errorOutline .. " ", warn = icons.warningTriangleNoBg .. " " },
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = true,
  diff_color = {
    added    = { fg = colors.green },
    modified = { fg = colors.orange },
    removed  = { fg = colors.red },
  },
  color = { bg = colors.violet },
  symbols = { added = icons.gitAdd .. " ", modified = icons.gitChange .. " ", removed = icons.gitRemove .. " " }, -- changes diff symbols
  cond = hide_in_width,
  separator = "%#SLSeparator#" .. "│ " .. "%*",
}

local filetype = {
  "filetype",
  icons_enabled = true,
  symbols = {
    unix = '', -- e712
    dos = '', -- e70f
    mac = '', -- e711
  }
}

local fileformat = {
  'fileformat',
  color = { fg = colors.fg },
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. "" .. "%*" .. "%#SLBranchName#",
  colored = true,
  color = { fg = colors.violet, gui = 'bold' },
}

local lspServer = {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = colors.fg, gui = 'bold' },
}


-- local progress = {
--   "progress",
--   color = "SLProgress",
--   fmt = function(str)
--     if str == "1%" then
--       return "TOP"
--     end
--     if str == "100%" then
--       return "BOT"
--     end
--     return str
--   end,
--   padding = 1,
-- }

local current_signature = function()
  if not pcall(require, "lsp_signature") then
    return
  end
  local sig = require("lsp_signature").status_line(30)
  -- return sig.label .. "🐼" .. sig.hint
  return "%#SLSeparator#" .. sig.hint .. "%*"
end

local progress = function()
  local current_line = vim.fn.line "."
  local total_lines = vim.fn.line "$"
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  -- return chars[index]
  return "%#SLProgress#" .. chars[index] .. "%*"
end

local spaces = {
  function()
    return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
  end,
  padding = 0,
  separator = "%#SLSeparator#" .. " │" .. "%*",
}

local location = {
  "location",
  color = function()
    return { fg = "#252525", bg = mode_color[vim.fn.mode()] }
  end,
}

local filename = {
  "filename",
  file_status = true,
  path = 0,
}

lualine.setup({
  options = {
    globalstatus = true,
    icons_enabled = true,
    -- theme = "auto",
    theme = 'tokyonight',
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "Outline", "dashboard", "fugitive", "gitcommit", "NvimTree" },
    always_divide_middle = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
    ignore_focus = {
      'NvimTree',
      'packer',
      'toggleterm',
      'dapui_scopes',
      'dapui_stacks',
      'dapui_breakpoints',
      'dapui_watches',
      'dap-repl',
    },
  },
  sections = {
    lualine_a = { mode, branch },
    lualine_b = { diagnostics },
    --       { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
    lualine_c = {
      lspServer
    },
    lualine_x = {
      progress,
      diff
    },
    lualine_y = { filetype, fileformat, "filesize" },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
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
    "nerdtree",
    "nvim-dap-ui",
    "nvim-tree",
    "symbols-outline",
    "toggleterm",
  },
})
