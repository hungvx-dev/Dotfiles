local M = {}

M.servers = {
  bashls = {},
  zk = {},
  dockerls = {},
  emmet_ls = {},
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
        diagnostics = {
          globals = { "vim", "HVIM", "reload" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
  },
  volar = {
    root_dir = require("lspconfig/util").root_pattern(
      "vue.config.js",
      "vue.config.ts",
      "vite.config.ts",
      "vite.config.js",
      "nuxt.config.ts",
      "nuxt.config.js"
    ),
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
  },
  tailwindcss = {
    root_dir = require("lspconfig/util").root_pattern(
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.ts",
      "tailwind.js",
      "tailwind.cjs"
    ),
    filetypes = { "html", "typescriptreact", "vue", "javascriptreact" },
    settings = {
      tailwindCSS = {
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
      },
    },
  },
}

M.setup = {
  tsserver = function(_, opts)
    require("typescript").setup({ server = opts })
    return true
  end,
}

return M
