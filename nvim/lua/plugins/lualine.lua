return {
  "nvim-lualine/lualine.nvim",
  enabled = HVIM.plugins.lualine,
  event = "VeryLazy",
  -- dependencies = { "mini.icons" },
  init = function()
    vim.g.lualine_laststatus = 3
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    vim.o.laststatus = vim.g.lualine_laststatus
    local theme = require("themes.feiyu.plugins.lualine")

    return {
      options = {
        icons_enabled = HVIM.use_icons,
        theme = theme.theme,
        globalstatus = vim.o.laststatus == 3,
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {
            "ministarter",
            "help",
            "dashboard",
            "alpha",
          },
        },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            padding = 0,
            fmt = function()
              return " "
            end,
          },
          {
            "branch",
            icon = "%#SLGitIcon#" .. HVIM.icons.Git.Branch .. "%*" .. "%#SLBranchName#",
          },
        },
        lualine_b = {},
        lualine_c = {
          {
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
            diff_color = theme.diff_color,
          },
          {
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
            cond = function()
              return vim.o.columns > 100
            end,
          },
        },
        lualine_x = {
          {
            function()
              return vim.t.is_maximized and HVIM.icons.UI.WindowMaximized or ""
            end,
          },
          { "searchcount", always_visible = false },
          "filetype",
        },
        lualine_y = {
          "location",
        },
        lualine_z = {
          {
            "progress",
            fmt = function()
              return "%P/%L"
            end,
          },
        },
      },
      extensions = {
        "fzf",
        "neo-tree",
        "mason",
        "lazy",
        "trouble",
        "man",
      },
    }
  end,
}
