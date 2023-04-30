local M = {}

require("lsp.handler").setup()
require("lsp.config").setup()

local opts = {
  servers = {
    bashls = {},
    emmet_ls = {},
    prismals = {},
    dockerls = {},
    yamlls = {
      settings = {
        yaml = {
          hover = true,
          completion = true,
          validate = true,
          schemaStore = {
            enable = true,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },
          schemas = require("schemastore").yaml.schemas(),
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
          format = { enable = true, },
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
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
      root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "vue.config.js",
        "vite.config.ts"),
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
      -- root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
    },
    tailwindcss = {
      filetypes = { "html", "typescriptreact", "vue" },
      root_dir = function(fname)
        local util = require "lspconfig/util"
        return util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.js", "tailwind.cjs")(fname)
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
              { "clsx\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              { "classnames\\(([^)]*)\\)", "'([^']*)'" },
            },
          },
          validate = true,
        },
      },
    },
  },
  setup = {
    tsserver = function(_, opts)
      require("utils").on_attach(function(client, buffer)
        if client.name == "tsserver" then
          -- stylua: ignore
          vim.keymap.set("n", "<leader>go", "<cmd>TypescriptOrganizeImports<CR>",
            { buffer = buffer, desc = "Organize Imports" })
          -- stylua: ignore
          vim.keymap.set("n", "<leader>gR", "<cmd>TypescriptRenameFile<CR>", { desc = "Rename File", buffer = buffer })
        end
      end)
      require("typescript").setup { server = opts }
      return true
    end,
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
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { setup }
  end
end

return M
