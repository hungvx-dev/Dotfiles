local M = {}

function M.opts()
  local header = [[
  ██╗  ██╗██╗   ██╗███╗   ██╗ ██████╗ ██╗   ██╗██╗  ██╗
  ██║  ██║██║   ██║████╗  ██║██╔════╝ ██║   ██║╚██╗██╔╝
  ███████║██║   ██║██╔██╗ ██║██║  ███╗██║   ██║ ╚███╔╝
  ██╔══██║██║   ██║██║╚██╗██║██║   ██║╚██╗ ██╔╝ ██╔██╗
  ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝ ╚████╔╝ ██╔╝ ██╗
  ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═══╝  ╚═╝  ╚═╝
  ]]
  local pad = string.rep(" ", 22)
  local new_section = function(name, action, section)
    return { name = name, action = action, section = pad .. section }
  end
  local items = {
    new_section(HVIM.icons.UI.Search .. "Find file", "Telescope find_files", "Telescope"),
    new_section(HVIM.icons.UI.OldFile .. "Recent files", "Telescope oldfiles", "Telescope"),
    new_section(HVIM.icons.UI.FindText .. "Find text", "Telescope live_grep", "Telescope"),
    new_section(HVIM.icons.UI.Lazy .. "Lazy", "Lazy", "Config"),
    new_section(HVIM.icons.UI.Quit .. "Quit", "qa", "Built-in"),
  }

  local starter = require("mini.starter")
    --stylua: ignore
    local config = {
      evaluate_single = true,
      header = header,
      items = items,
      content_hooks = {
        starter.gen_hook.adding_bullet(pad .. "░ ", false),
        starter.gen_hook.aligning("center", "center"),
      },
    }
  return config
end

function M.setup(_, config)
  if vim.o.filetype == "lazy" then
    vim.cmd.close()
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniStarterOpened",
      callback = function()
        require("lazy").show()
      end,
    })
  end

  local starter = require("mini.starter")
  starter.setup(config)

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function(ev)
      local stats = require("lazy").stats()
      local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
      local pad_footer = string.rep(" ", 8)
      starter.config.footer = pad_footer .. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
      if vim.bo[ev.buf].filetype == "ministarter" then
        pcall(starter.refresh)
      end
    end,
  })
end
return M
