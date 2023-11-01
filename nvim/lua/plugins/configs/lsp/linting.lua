local M = {}

function M.setup()
  local status_ok, lint = pcall(require, "lint")
  if not status_ok then
    return
  end

  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    vue = { "eslint_d" },
    fish = { "fish" },
  }

  local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged" }, {
    group = lint_augroup,
    callback = function()
      lint.try_lint()
    end,
  })

  vim.keymap.set("n", "gl", function()
    lint.try_lint()
  end, { desc = "Trigger linting for current file" })
end

return M
