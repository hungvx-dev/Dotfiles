local M = {}

local Util = require "utils"

require("lsp.handler").setup()
require("lsp.config").setup()

local opts = {
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
      settings = {
        json = {
          format = { enable = true },
          validate = { enable = true },
          schemas = require("schemastore").json.schemas(),
        },
      },
    },
    lua_ls = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "lvim", "reload" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.stdpath "config" .. "/lua"] = true,
            },
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
      -- filetypes = { "typescript", "typescriptreact", "vue" },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "typescript.tsx" },
      root_dir = require("lspconfig.util").root_pattern(
        "vue.config.js",
        "vue.config.ts",
        "vite.config.ts",
        "vite.config.js",
        "nuxt.config.ts",
        "nuxt.config.js"
      ),
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
      root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
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

function M.setup()
  local servers = opts.servers

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  local lsp = require "lspconfig"

  local function setup(server)
    local server_opts = vim.tbl_deep_extend("force", {
      capabilities = vim.deepcopy(capabilities),
    }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup["*"] then
      if opts.setup["*"](server, server_opts) then
        return
      end
    end

    lsp[server].setup(server_opts)
  end

  -- temp fix for lspconfig rename
  -- https://github.com/neovim/nvim-lspconfig/pull/2439
  local mappings = require "mason-lspconfig.mappings.server"
  if not mappings.lspconfig_to_package.lua_ls then
    mappings.lspconfig_to_package.lua_ls = "lua-language-server"
    mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
  end

  local have_mason, mlsp = pcall(require, "mason-lspconfig")
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
  end

  local ensure_installed = {} ---@type string[]
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts

      -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed, handlers = { setup } }
  end

  if Util.lsp_get_config "volar" and Util.lsp_get_config "tsserver" then
    local is_volar = require("lspconfig.util").root_pattern(
      "vite.config.json",
      "vite.config.jsonc",
      "vite.config.ts",
      "vite.config.js",
      "vue.config.js",
      "vue.config.ts",
      "nuxt.config.ts",
      "nuxt.config.js"
    )
    Util.lsp_disable("tsserver", is_volar)
    Util.lsp_disable("volar", function(root_dir)
      return not is_volar(root_dir)
    end)
  end
end

return M
