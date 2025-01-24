return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  enabled = HVIM.plugins.lualine,
  dependencies = { "mini.icons" },
  init = function()
    if vim.fn.argc(-1) > 0 then
      vim.o.statusline = " "
    else
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local feiyu = require("themes.feiyu")
    local theme = feiyu.lualine()
    local colors = feiyu.colors
    vim.api.nvim_set_hl(0, "SLGitIcon", { fg = colors.orange, bg = colors.fg_gutter })
    vim.api.nvim_set_hl(0, "SLBranchName", { fg = colors.fg, bg = colors.fg_gutter, bold = true })

    local M = {}
    M.has_fzf = function()
      return pcall(require, "fzf-lua")
    end
    M.fzf_picker = {
      function()
        if not M.has_fzf() then
          return ""
        end

        local info_string = vim.inspect(require("fzf-lua").get_info()["fnc"])
        return info_string:gsub('"', "")
      end,
      color = { fg = "#15161e" },
    }

    M.fzf_element = function()
      if not M.has_fzf() then
        return ""
      end

      local fzf = require("fzf-lua")
      local selected = fzf.get_info().selected
      return fzf.path.entry_to_file(selected).path
    end

    M.fzf_statusline = {
      function()
        return "FZF"
      end,
      color = { fg = colors.black },
    }

    return {
      options = {
        icons_enabled = HVIM.use_icons,
        theme = theme,
        globalstatus = true,
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
        lualine_b = {
          -- {
          --   "diagnostics",
          --   sources = { "nvim_lsp" },
          --   symbols = HVIM.bold_signs,
          --   always_visible = true,
          -- }
        },
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
            diff_color = {
              added = { fg = colors.git.add },
              modified = { fg = colors.git.change },
              removed = { fg = colors.git.delete },
            },
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
            color = { fg = colors.black },
          },
        },
      },
      extensions = {
        {
          sections = {
            lualine_a = { M.fzf_statusline },
            lualine_y = { M.fzf_element },
            lualine_z = { M.fzf_picker },
          },
          filetypes = { "fzf" },
        },
        "neo-tree",
        "mason",
        "lazy",
        "trouble",
        "man",
      },
    }
  end,
}
