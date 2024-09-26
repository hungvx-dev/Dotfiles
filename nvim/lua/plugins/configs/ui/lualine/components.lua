local conditions = require("plugins.configs.ui.lualine.conditions")
local colors = require("tokyonight.colors").setup()
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

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = true })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "NONE" })

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. HVIM.icons.Git.Branch .. "%*" .. "%#SLBranchName#",
}

local filetype = { "filetype", cond = nil, padding = { left = 0, right = 1 }, color = {} }

local diff = {
  "diff",
  source = function()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end,
  symbols = {
    added = HVIM.icons.Git.LineAdded .. " ",
    modified = HVIM.icons.Git.LineModified .. " ",
    removed = HVIM.icons.Git.LineRemoved .. " ",
  },
  padding = { left = 2 },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
}

local mode = {
  function()
    return HVIM.icons.UI.Line.Full
  end,
  padding = { left = 0, right = 0 },
  color = function()
    return { fg = mode_color[vim.fn.mode()] }
  end,
  cond = nil,
}

local location = { "location", padding = { left = 0, right = 1 } }

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  symbols = {
    error = HVIM.icons.Diagnostics.BoldError .. " ",
    warn = HVIM.icons.Diagnostics.BoldWarning .. " ",
    info = HVIM.icons.Diagnostics.BoldInformation .. " ",
    hint = HVIM.icons.Diagnostics.BoldHint .. " ",
  },
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

local progress = {
  "progress",
  fmt = function()
    return "%P/%L"
  end,
  color = { fg = "#15161e" },
}

local lsp = {
  function()
    local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
    if next(buf_clients) == nil then
      return "LS Inactive"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
      table.insert(buf_client_names, client.name)
    end
    return "[" .. table.concat(buf_client_names, ", ") .. "]"
  end,
  color = { gui = "bold" },
  cond = conditions.hide_in_width,
}

return {
  mode = mode,
  branch = branch,
  diff = diff,
  diagnostics = diagnostics,
  filetype = filetype,
  location = location,
  progress = progress,
  lsp = lsp,
}
