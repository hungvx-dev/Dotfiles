local M = {}

function M.opts()
  local dashboard = require("alpha.themes.dashboard")

  local logo = [[
  "██╗  ██╗██╗   ██╗███╗   ██╗ ██████╗ ██╗   ██╗██╗  ██╗"
  "██║  ██║██║   ██║████╗  ██║██╔════╝ ██║   ██║╚██╗██╔╝"
  "███████║██║   ██║██╔██╗ ██║██║  ███╗██║   ██║ ╚███╔╝ "
  "██╔══██║██║   ██║██║╚██╗██║██║   ██║╚██╗ ██╔╝ ██╔██╗ "
  "██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝ ╚████╔╝ ██╔╝ ██╗"
  "╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝"
      ]]

  dashboard.section.header.val = vim.split(logo, "\n")
  dashboard.section.buttons.val = {
    dashboard.button("o", HVIM.icons.UI.OldFile .. " Old files", "<cmd> Telescope oldfiles <cr>"),
    dashboard.button("p", HVIM.icons.UI.Search .. " Find file", "<cmd> Telescope find_files <cr>"),
    dashboard.button("s", HVIM.icons.UI.FindText .. " Find text", "<cmd> Telescope live_grep <cr>"),
    dashboard.button("l", HVIM.icons.UI.Lazy .. " Lazy", "<cmd> Lazy <cr>"),
    dashboard.button("q", HVIM.icons.UI.Quit .. " Quit", "<cmd> qa <cr>"),
  }

  for _, button in ipairs(dashboard.section.buttons.val) do
    button.opts.hl = "AlphaButtons"
    button.opts.hl_shortcut = "AlphaShortcut"
  end

  dashboard.section.header.opts.hl = "AlphaHeader"
  dashboard.section.buttons.opts.hl = "AlphaButtons"
  dashboard.section.footer.opts.hl = "AlphaFooter"
  dashboard.opts.layout[1].val = 8

  return dashboard.opts
end

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local opts = M.opts()
  alpha.setup(opts)

  -- Disable folding on alpha buffer
  vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])

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
end

return M
