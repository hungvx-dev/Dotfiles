local M = {}

function M.config()
  hvim.builtin.mason = {
    ensure_installed = {
      "stylua",
      "shfmt",
      -- "codespell",
      -- "prettier",
      -- "prettier",
      "prettierd",
      "eslint_d",
    },
    ui = {
      border = "rounded",
      keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-c>",
        apply_language_filter = "<C-f>",
      },
      icons = {
        package_installed = "◍",
        package_pending = "◍",
        package_uninstalled = "◍",
      },
    },
    PATH = "prepend",
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
  }
end

M.config()

function M.setup()
  local status_ok, mason = pcall(require, "mason")
  if not status_ok then
    return
  end

  mason.setup(hvim.builtin.mason)
  local mr = require "mason-registry"
  local function ensure_installed()
    for _, tool in ipairs(hvim.builtin.mason.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end
  if mr.refresh then
    mr.refresh(ensure_installed)
  else
    ensure_installed()
  end
end

return M
