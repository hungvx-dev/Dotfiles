return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "TextChanged", "TextChangedI" },
      linters_by_ft = {
        -- css = { "eslint_d" },
        -- less = { "eslint_d" },
        -- scss = { "eslint_d" },
        -- graphql = { "eslint_d" },
        -- html = { "eslint_d" },
        -- javascript = { "oxlint", "eslint_d" },
        -- javascriptreact = { "oxlint", "eslint_d" },
        -- json = { "oxlint", "eslint_d" },
        -- jsonc = { "oxlint", "eslint_d" },
        -- typescript = { "oxlint", "eslint_d" },
        -- typescriptreact = { "oxlint", "eslint_d" },
        -- vue = { "oxlint", "eslint_d" },
        yaml = { "yamllint" },
        docker = { "hadolint" },
        luau = { "selene" },
        -- ["*"] = { "cspell" },
      },
      linters = {
        -- eslint_d = {
        --   args = {
        --     "--no-warn-ignored", -- Ignore warnings, support Eslint 9
        --     "--format",
        --     "json",
        --     "--stdin",
        --     "--stdin-filename",
        --     function()
        --       return vim.api.nvim_buf_get_name(0)
        --     end,
        --   },
        --   condition = function()
        --     local config_files = {
        --       ".eslintrc",
        --       ".eslintrc.js",
        --       ".eslintrc.cjs",
        --       ".eslintrc.yaml",
        --       ".eslintrc.yml",
        --       ".eslintrc.json",
        --       "eslint.config.js",
        --       "eslint.config.mjs",
        --       "eslint.config.cjs",
        --       "eslint.config.ts",
        --       "eslint.config.mts",
        --       "eslint.config.cts",
        --     }
        --     for _, config_file in ipairs(config_files) do
        --       if vim.fn.filereadable(vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")) == 1 then
        --         return true
        --       end
        --     end
        --     return false
        --   end,
        -- },
        -- biomejs = {
        --   condition = function()
        --     local config_files = { "biome.json", "biome.jsonc" }
        --     for _, config_file in ipairs(config_files) do
        --       local path = vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")
        --       if path ~= "" and vim.fn.filereadable(path) == 1 then
        --         return true
        --       end
        --     end
        --     return false
        --   end,
        -- },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      local M = {}

      for name, linter in pairs(opts.linters) do
        if type(linter) == "table" and type(lint.linters[name]) == "table" then
          lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
          if type(linter.prepend_args) == "table" then
            lint.linters[name].args = lint.linters[name].args or {}
            vim.list_extend(lint.linters[name].args, linter.prepend_args)
          end
        else
          lint.linters[name] = linter
        end
      end
      lint.linters_by_ft = opts.linters_by_ft

      function M.debounce(ms, fn)
        local timer = vim.uv.new_timer()
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      function M.lint()
        local names = lint._resolve_linter_by_ft(vim.bo.filetype)

        names = vim.list_extend({}, names)

        if #names == 0 then
          vim.list_extend(names, lint.linters_by_ft["_"] or {})
        end

        vim.list_extend(names, lint.linters_by_ft["*"] or {})

        local ctx = { filename = vim.api.nvim_buf_get_name(0) }
        ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
        names = vim.tbl_filter(function(name)
          local linter = lint.linters[name]
          return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
        end, names)

        if #names > 0 then
          lint.try_lint(names)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = M.debounce(200, M.lint),
      })
    end,
  },
}
