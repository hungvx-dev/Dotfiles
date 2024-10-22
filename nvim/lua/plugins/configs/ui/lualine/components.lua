local conditions = require("plugins.configs.ui.lualine.conditions")
local colors = require("tokyonight.colors").setup()

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = true })
-- vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "NONE" })

local mode = {
  "mode",
  padding = { padding_left = 1, padding_right = 0 },
  fmt = function()
    return " "
  end,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. HVIM.icons.Git.Branch .. "%*" .. "%#SLBranchName#",
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_lsp" },
  symbols = HVIM.bold_signs,
  always_visible = true,
}

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
  symbols = HVIM.git_line,
  padding = 2,
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
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

local location = { "location", padding = 1 }
local filetype = { "filetype", padding = 1 }

local progress = {
  "progress",
  fmt = function()
    return "%P/%L"
  end,
  color = { fg = "#15161e" },
}

local maximized = {
  function()
    return vim.t.is_maximized and HVIM.icons.UI.WindowMaximized or ""
  end,
}

local searchcount = { "searchcount", always_visible = false }

return {
  mode = mode,
  branch = branch,
  diff = diff,
  diagnostics = diagnostics,
  filetype = filetype,
  location = location,
  progress = progress,
  lsp = lsp,
  maximized = maximized,
  searchcount = searchcount,
}
