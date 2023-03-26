local M = {}

require("lsp.handler").setup()
require("lsp.config").setup()

local opts = {
  servers = {
    bashls = {},
    emmet_ls = {},
    prismals = {},
    yamlls = {
      schemaStore = {
        enable = true,
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
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand "$VIMRUNTIME/lua"] = true,
              [vim.fn.stdpath "config" .. "/lua"] = true,
            },
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
    -- eslint_d = {
    --   settings = {
    --     -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
    --     workingDirectory = { mode = "auto" },
    --   },
    -- },
    tsserver = {
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    },

    volar = {
      filetypes = { "typescript", "typescriptreact", "vue" },
    },

    tailwindcss = {
      filetypes = { "html", "typescriptreact", "vue" },
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
  },
  setup = {
    -- eslint_d = function()
    --   -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   --   callback = function(event)
    --   --     if require("lspconfig.util").get_active_client_by_name(event.buf, "eslint") then
    --   --       vim.cmd("EslintFixAll")
    --   --     end
    --   --   end,
    --   -- })
    -- end,
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
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

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
