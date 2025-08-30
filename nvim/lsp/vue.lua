---@type vim.lsp.Config
return {
  cmd = { "vue-language-server", "--stdio" },
  root_markers = { "tsconfig.json", "package.json", "jsconfig.json" },
  filetypes = { "vue" },
  on_init = function(client)
    local retries = 0

    ---@param _ lsp.ResponseError
    ---@param result any
    ---@param context lsp.HandlerContext
    local function typescriptHandler(_, result, context)
      local ts_client = vim.lsp.get_clients({ bufnr = context.bufnr, name = "ts_ls" })[1] or vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })[1] or vim.lsp.get_clients({ bufnr = context.bufnr, name = "typescript-tools" })[1]

      if not ts_client then
        -- there can sometimes be a short delay until `ts_ls`/`vtsls` are attached so we retry for a few times until it is ready
        if retries <= 10 then
          retries = retries + 1
          vim.defer_fn(function()
            typescriptHandler(_, result, context)
          end, 100)
        else
          vim.notify("Could not find `ts_ls`, `vtsls`, or `typescript-tools` lsp client required by `vue_ls`.", vim.log.levels.ERROR)
        end
        return
      end

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
        command = "typescript.tsserverRequest",
        arguments = {
          command,
          payload,
        },
      }, { bufnr = context.bufnr }, function(_, r)
        local response_data = { { id, r and r.body } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify("tsserver/response", response_data)
      end)
    end

    client.handlers["tsserver/request"] = typescriptHandler
  end,
  settings = {
    typescript = {
      updateImportsOnFileMove = { enabled = "always" },
      suggest = { completeFunctionCalls = true },
      tsserver = {
        maxTsServerMemory = 8192,
      },
      inlayHints = {
        parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
  on_attach = function(client, bufnr)
    vim.lsp.config["*"].on_attach(client, bufnr)
    client.server_capabilities.semanticTokensProvider.full = true
  end,
}
