local lspconfig_configs = require'lspconfig.configs'
local lspconfig_util = require 'lspconfig.util'

local volar_cmd = {'vue-language-server', '--stdio'}
local volar_root_dir = lspconfig_util.root_pattern("package.json", ".git/")

local filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local filetypes_with_json = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
local VOLAR_DEBUG = false
-- Api - port 6009
-- Document - port 6010
-- Html - port 6011
--
local function volar_debug_cmd_factory(port, executable_path)
  if VOLAR_DEBUG then
    return {'node', '--inspect=:' .. port, executable_path, '--stdio'}
  end

  return volar_cmd 
end

local script_path = os.getenv("HOME") .. "/.local/src/volar/node_modules/@volar/server/out/index.js"
local tslib_path = os.getenv("HOME") .. "/.local/src/volar/node_modules/typescript/lib/tsserverlibrary.js"

local function get_smartass_typescript_server_path(root_dir)
  local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
  local local_tsserverlib = project_root ~= nil and lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
  local global_tsserverlib = '/lib/node_modules/typescript/lib/tsserverlibrary.js'
  if local_tsserverlib and lspconfig_util.path.exists(local_tsserverlib) then
    return local_tsserverlib
  else
    return global_tsserverlib
  end
end

local function smartass_on_new_config(new_config, new_root_dir)
  new_config.init_options.typescript.serverPath = get_smartass_typescript_server_path(new_root_dir)
end

local settings = {
  volar = {
    codeLens = {
      scriptSetupTools = true,
      references = true,
      pugTools = true,
    },
    lowPowerMode = false,
    -- formatting = { printWidth = 100 },
    -- autoCompleteRefs = true,
    -- what am i smoking this is a vscode client option
    takeOverMode = { enabled = true}, -- default is "auto" which launches only when builtin vscode TS ext is enabled. wonder how that logic behaves in neovim where there's no such builtin TS ext
    completion = {
      preferredTagNameCase = 'pascal',
      preferredAttrNameCase = 'kebab',
      autoImportComponent = true,
    },
    preview = {
      port = 3333,
      backgroundColor = '#fff',
      transparentGrid = true,
    }
  },
}

local commands = {
  VolarHtmlToPug = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.html-to-pug',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarPugToHtml = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.pug-to-html',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUseSetupSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.use-setup-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUnuseSetupSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.unuse-setup-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUseRefSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.use-ref-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarUnuseRefSugar = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.unuse-ref-sugar',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarShowReferences = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.show-references',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarConvertToKebabCase = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.server.executeConvertToKebabCase',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
  VolarConvertToPascalCase = {
    function()
      vim.lsp.buf.execute_command({
        command = 'volar.server.executeConvertToPascalCase',
        arguments = { vim.uri_from_bufnr(0) }
      })
    end,
  },
}

-- local volar_common = {
--   root_dir = volar_root_dir,
--   on_new_config = smartass_on_new_config,
--   trace = 'verbose',
--   settings = settings,
-- }

lspconfig_configs.volar = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    on_new_config = smartass_on_new_config,
    trace = 'verbose',
    settings = settings,
    filetypes = filetypes_with_json,
    commands = commands,
    init_options = {
      typescript = {
        serverPath = ''
      },
      languageFeatures = {
        references = true,
        implementation = true,
        definition = true,
        typeDefinition = true,
        callHierarchy = true,
        hover = true,
        rename = true,
        renameFileRefactoring = true,
        signatureHelp = true,
        codeAction = true,
        workspaceSymbol = true,
        completion = {
          defaultTagNameCase = 'both',
          defaultAttrNameCase = 'kebabCase',
          -- getDocumentNameCasesRequest = true,
          -- getDocumentSelectionRequest = true,
        },
        schemaRequestService = true,
        documentHighlight = true,
        documentLink = true,
        codeLens = true,
        semanticTokens = true,
        diagnostics = true,
      },
      documentFeatures = {
        selectionRange = true,
        foldingRange = true,
        linkedEditingRange = true,
        documentSymbol = true,
        documentColor = true,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
      },
    }
  }
}
