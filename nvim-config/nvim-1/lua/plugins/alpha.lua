return {
  "goolord/alpha-nvim",
  enabled = HVIM.plugins.alpha,
  event = "VimEnter",
  dependencies = { "mini.icons" },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local logo = {
      "██╗  ██╗██╗   ██╗███╗   ██╗ ██████╗ ██╗   ██╗██╗  ██╗",
      "██║  ██║██║   ██║████╗  ██║██╔════╝ ██║   ██║╚██╗██╔╝",
      "███████║██║   ██║██╔██╗ ██║██║  ███╗██║   ██║ ╚███╔╝",
      "██╔══██║██║   ██║██║╚██╗██║██║   ██║╚██╗ ██╔╝ ██╔██╗",
      "██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝ ╚████╔╝ ██╔╝ ██╗",
      "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝",
    }

    dashboard.section.header.val = logo
    dashboard.section.header.opts.position = "center"

    dashboard.section.buttons.val = {
      dashboard.button("o", "░ " .. HVIM.icons.UI.OldFile .. "Old files", "<cmd>FzfLua oldfiles<cr>"),
      dashboard.button("p", "░ " .. HVIM.icons.UI.Search .. "Find file", "<cmd>FzfLua files<cr>"),
      dashboard.button("s", "░ " .. HVIM.icons.UI.FindText .. "Find text", "<cmd>FzfLua live_grep<cr>"),
      dashboard.button("l", "░ " .. HVIM.icons.UI.Lazy .. "Lazy", "<cmd>Lazy <cr>"),
      dashboard.button("q", "░ " .. HVIM.icons.UI.Quit .. "Quit", "<cmd>qa <cr>"),
    }
    dashboard.section.buttons.opts.spacing = 1
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.cursor = 1
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaButtons"
    end

    dashboard.opts.layout[1].val = 8

    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
