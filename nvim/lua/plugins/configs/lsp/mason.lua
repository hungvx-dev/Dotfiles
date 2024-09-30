local M = {}

M.opts = {
  ensure_installed = {
    -- For Formatter
    "stylua", -- For lua
    "shfmt", -- For sh
    "prettierd",
    -- "prettier",

    -- For Linter
    "eslint_d",
    "hadolint", -- For docker
    "cspell",
  },
  ui = {
    border = "rounded",
    icons = {
      package_installed = HVIM.icons.Mason.Installed,
      package_pending = HVIM.icons.Mason.Pending,
      package_uninstalled = HVIM.icons.Mason.Uninstall,
    },
  },
}

function M.setup()
  require("mason").setup(M.opts)

  local mr = require("mason-registry")
  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- trigger FileType event to possibly load this newly installed LSP server
      require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
      })
    end, 100)
  end)

  mr.refresh(function()
    for _, tool in ipairs(M.opts.ensure_installed) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end)
end

return M
