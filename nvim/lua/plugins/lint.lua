return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      events = { "BufWritePost", "BufReadPost", "TextChanged" },
      linters_by_ft = {
        css = { "biome", "eslint_d" },
        less = { "biome", "eslint_d" },
        scss = { "biome", "eslint_d" },
        graphql = { "biome", "eslint_d" },
        html = { "biome", "eslint_d" },
        javascript = { "biome", "eslint_d" },
        javascriptreact = { "biome", "eslint_d" },
        json = { "biome", "eslint_d" },
        jsonc = { "biome", "eslint_d" },
        typescript = { "biome", "eslint_d" },
        typescriptreact = { "biome", "eslint_d" },
        vue = { "biome", "eslint_d" },
        yaml = { "yamllint" },
        docker = { "hadolint" },
      },
      linters = {
        eslint_d = {
          cmd = function()
            local local_binary = vim.fn.fnamemodify("./node_modules/.bin/" .. "eslint_d", ":p")
            return vim.loop.fs_stat(local_binary) and local_binary or "eslint_d"
          end,
          args = {
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
              return vim.api.nvim_buf_get_name(0)
            end,
          },
          stdin = true,
          stream = "stdout",
          ignore_exitcode = true,
          parser = function(output, bufnr)
            local result = require("lint.linters.eslint").parser(output, bufnr)
            for _, d in ipairs(result) do
              d.source = "eslint_d"
            end
            return result
          end,
          condition = function()
            local config_files = { ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".eslintrc.yaml", ".eslintrc.yml", "eslint.config.mts", "eslint.config.mjs" }
            for _, config_file in ipairs(config_files) do
              if vim.fn.filereadable(vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")) == 1 then
                return true
              end
            end
            return false
          end,
        },
        biome = {
          cmd = function()
            local local_binary = vim.fn.fnamemodify("./node_modules/.bin/" .. "biome", ":p")
            return vim.loop.fs_stat(local_binary) and local_binary or "biome"
          end,
          args = { "lint" },
          stdin = false,
          ignore_exitcode = true,
          stream = "both",
          parser = function(output)
            local diagnostics = {}
            local fetch_message = false
            local lnum, col, code, message
            for _, line in ipairs(vim.fn.split(output, "\n")) do
              if fetch_message then
                _, _, message = string.find(line, "%s×(.+)")

                if message then
                  message = (message):gsub("^%s+×%s*", "")

                  table.insert(diagnostics, {
                    source = "biomejs",
                    lnum = tonumber(lnum) - 1,
                    col = tonumber(col),
                    message = message,
                    code = code,
                  })

                  fetch_message = false
                end
              else
                _, _, lnum, col, code = string.find(line, "[^:]+:(%d+):(%d+)%s([%a%/]+)")

                if lnum then
                  fetch_message = true
                end
              end
            end

            return diagnostics
          end,
          condition = function(ctx)
            local config_files = { "biome.json", "biome.jsonc" }
            for _, config_file in ipairs(config_files) do
              local path = vim.fn.findfile(config_file, vim.fn.getcwd() .. ";")
              if path ~= "" and vim.fn.filereadable(path) == 1 then
                vim.notify("Found Biome config: " .. path, vim.log.levels.INFO) -- Debug
                return true
              end
            end
            vim.notify("No Biome config found, skipping biome", vim.log.levels.INFO) -- Debug
            return false
          end,
        },
      },
    },
    config = function(_, opts)
      -- vim.env.ESLINT_D_PPID = vim.fn.getpid()
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      lint.linters = opts.linters
      local M = {}
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
