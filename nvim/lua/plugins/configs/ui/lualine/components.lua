local conditions = require("plugins.configs.ui.lualine.conditions")
local colors = require("tokyonight.colors").setup()

vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLBranchName", { fg = "#D4D4D4", bg = "#303030", bold = true })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D4D4D4", bg = "#303030" })
vim.api.nvim_set_hl(0, "SLSeparator", { fg = "#808080", bg = "NONE" })
vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local branch = {
  "branch",
  icons_enabled = true,
  icon = "%#SLGitIcon#" .. HVIM.icons.Git.Branch .. "%*" .. "%#SLBranchName#",
  colored = true,
  -- color = { fg = colors.violet, gui = 'bold' },
}

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

return {
  mode = {
    function()
      return "▊"
    end,
    padding = { left = 0, right = 0 },
    color = function()
      return { fg = mode_color[vim.fn.mode()] }
    end,
    cond = nil,
  },
  branch = branch,
  filename = { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
  diff = {
    "diff",
    source = diff_source,
    symbols = {
      added = HVIM.icons.Git.LineAdded .. " ",
      modified = HVIM.icons.Git.LineModified .. " ",
      removed = HVIM.icons.Git.LineRemoved .. " ",
    },
    padding = { left = 2, right = 1 },
    diff_color = {
      added = { fg = colors.green },
      modified = { fg = colors.yellow },
      removed = { fg = colors.red },
    },
    colored = true,
    cond = nil,
  },
  diagnostics = diagnostics,
  treesitter = {
    function()
      return HVIM.icons.UI.Tree
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = conditions.hide_in_width,
  },
  location = { "location", padding = { left = 0, right = 1 } },
  progress = {
    "progress",
    fmt = function()
      return "%P/%L"
    end,
    color = { fg = "#15161e" },
  },

  spaces = {
    function()
      local shiftwidth = vim.filetype.get_option("vim", "shiftwidth")
      return HVIM.icons.UI.Tab .. " " .. shiftwidth
    end,
    padding = 0,
    separator = "%#SLSeparator#" .. " │" .. "%*",
    color = { bg = "NONE" },
  },
  encoding = {
    "o:encoding",
    fmt = string.upper,
    color = {},
    cond = conditions.hide_in_width,
  },
  filetype = { "filetype", cond = nil, padding = { left = 1, right = 1 }, color = {} },
  scrollbar = {
    function()
      local current_line = vim.fn.line(".")
      local total_lines = vim.fn.line("$")
      local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
      local line_ratio = current_line / total_lines
      local index = math.ceil(line_ratio * #chars)
      return chars[index]
    end,
    padding = { left = 0, right = 0 },
    color = "SLProgress",
    cond = nil,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      local unique_client_names = vim.fn.uniq(buf_client_names)

      local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

      return language_servers
    end,
    color = { gui = "bold" },
    cond = conditions.hide_in_width,
  },
  lazy = { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = { fg = "#2ac3de" } },
}
