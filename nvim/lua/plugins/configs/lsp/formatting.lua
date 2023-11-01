local M = {}

M.opts = {
  formatters_by_ft = {
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    javascriptreact = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    vue = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    json = { { "prettierd", "prettier" } },
    yaml = { { "prettierd", "prettier" } },
    markdown = { { "prettierd", "prettier" } },
    graphql = { { "prettierd", "prettier" } },
    sh = { "shfmt" },
    fish = { "fish_indent" },
    lua = { "stylua" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
}

function M.setup()
  local status_ok, conform = pcall(require, "conform")
  if not status_ok then
    return
  end

  conform.setup(M.opts)
  vim.keymap.set({ "n", "v" }, "gf", function()
    conform.format(M.opts.format_on_save)
  end, { desc = "Format file or range (in visual mode)" })
end

return M
