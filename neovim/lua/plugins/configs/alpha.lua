local dashboard = require "alpha.themes.dashboard"
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
  dashboard.button("o", hvim.icons.UI.OldFile .. " Old files", "<cmd> Telescope oldfiles <cr>"),
  dashboard.button("p", hvim.icons.UI.Search .. " Find file", "<cmd> Telescope find_files <cr>"),
  dashboard.button("s", hvim.icons.UI.FindText .. " Find text", "<cmd> Telescope live_grep <cr>"),
  dashboard.button("l", hvim.icons.UI.Lazy .. " Lazy", "<cmd> Lazy <cr>"),
  dashboard.button("q", hvim.icons.UI.Quit .. " Quit", "<cmd> qa <cr>"),
}
for _, button in ipairs(dashboard.section.buttons.val) do
  button.opts.hl = "AlphaButtons"
  button.opts.hl_shortcut = "AlphaShortcut"
end
dashboard.section.header.opts.hl = "AlphaHeader"
dashboard.section.buttons.opts.hl = "AlphaButtons"
dashboard.section.footer.opts.hl = "AlphaFooter"
dashboard.opts.layout[1].val = 8

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
