local opts = {
  autoformat = true,
  servers = {
    bashls = {},
    emmet_ls = {},
    prismals = {},
    dockerls = {},
    -- sqlls = {},
    yamlls = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      -- lazy-load schemastore when needed
      on_new_config = function(new_config)
        new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
        vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
      end,
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          keyOrdering = false,
          hover = true,
          completion = true,
          format = {
            enable = true,
          },
          validate = true,
          schemaStore = {
            -- Must disable built-in schemaStore support to use
            -- schemas from SchemaStore.nvim plugin
            enable = false,
            -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            url = "",
          },
        },
      },
    },
    cssls = {
      css = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
      scss = {
        lint = {
          unknownAtRules = "ignore",
        },
      },
    },
    jsonls = {
      on_new_config = function(new_config)
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end,
      settings = {
        json = {
          format = {
            enable = true,
          },
          validate = { enable = true },
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = {
            globals = { "vim", "lvim", "reload" },
          },
          workspace = {
            checkThirdParty = false,
            -- library = {
            --   [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            --   [vim.fn.stdpath "config" .. "/lua"] = true,
            -- },
          },
          telemetry = { enable = false },
          runtime = {
            version = "LuaJIT",
            special = {
              reload = "require",
            },
          },
        },
      },
    },
    volar = {
      root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.root_pattern(
          "vue.config.js",
          "vue.config.ts",
          "vite.config.ts",
          "vite.config.js",
          "nuxt.config.ts",
          "nuxt.config.js"
        )(fname)
      end,
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "typescript.tsx" },
      settings = {
        volar = {
          codeLens = {
            references = true,
            pugTools = true,
            scriptSetupTools = true,
          },
        },
      },
    },
    tsserver = {
      settings = {
        typescript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        javascript = {
          format = {
            indentSize = vim.o.shiftwidth,
            convertTabsToSpaces = vim.o.expandtab,
            tabSize = vim.o.tabstop,
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
      root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.root_pattern("package.json", "tsconfig.json", "jsconfig.json")(fname)
      end,
    },
    tailwindcss = {
      filetypes = { "html", "typescriptreact", "vue" },
      root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.ts",
          "tailwind.js",
          "tailwind.cjs"
        )(fname)
      end,
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          experimental = {
            classRegex = {
              "tw`([^`]*)",
              'tw="([^"]*)',
              'tw={"([^"}]*)',
              "tw\\.\\w+`([^`]*)",
              "tw\\(.*?\\)`([^`]*)",
              { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              { "classnames\\(([^)]*)\\)", "'([^']*)'" },
            },
          },
          validate = true,
        },
      },
    },
    -- eslint = {
    --   settings = {
    --     -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
    --     workingDirectory = { mode = "auto" },
    --   },
    -- },
  },
  setup = {
    tsserver = function(_, opts)
      require("typescript").setup { server = opts }
      return true
    end,
    -- eslint = function()
    --   vim.api.nvim_create_autocmd("BufWritePre", {
    --     callback = function(event)
    --       local client = vim.lsp.get_active_clients({ bufnr = event.buf, name = "eslint" })[1]
    --       if client then
    --         local diag = vim.diagnostic.get(event.buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
    --         if #diag > 0 then
    --           vim.cmd "EslintFixAll"
    --         end
    --       end
    --     end,
    --   })
    -- end,
  },
}

return opts
