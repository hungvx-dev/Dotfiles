local diagnostics = require("diagnostics")
local lsp_buf = require("lsp_buf")

local M = {}
local map = vim.keymap.set

--- @param client vim.lsp.Client
--- @param buf integer
function M.keymaps(client, buf)
  local opts = { buffer = buf, noremap = true }

  map("n", "grr", function()
    lsp_buf.references({
      reuse_win = true,
      on_list = function()
        if HVIM.plugins.fzf then
          local fzf = require("fzf-lua")
          fzf.lsp_references()
        elseif HVIM.plugins.telescope then
          local builtin = require("telescope.builtin")
          builtin.lsp_references()
        end
      end,
    })
  end, opts)

  map("n", "gd", function()
    lsp_buf.definition({
      reuse_win = true,
      on_list = function()
        if HVIM.plugins.fzf then
          local fzf = require("fzf-lua")
          fzf.lsp_definitions()
        elseif HVIM.plugins.telescope then
          local builtin = require("telescope.builtin")
          builtin.lsp_definitions()
        end
      end,
    })
  end, opts)

  map("n", "gi", function()
    lsp_buf.implementation({
      reuse_win = true,
      on_list = function()
        if HVIM.plugins.fzf then
          local fzf = require("fzf-lua")
          fzf.lsp_implementations()
        elseif HVIM.plugins.telescope then
          local builtin = require("telescope.builtin")
          builtin.lsp_implementations()
        end
      end,
    })
  end, opts)

  map("n", "gt", function()
    lsp_buf.type_definition({
      reuse_win = true,
      on_list = function()
        if HVIM.plugins.fzf then
          local fzf = require("fzf-lua")
          fzf.lsp_typedefs()
        elseif HVIM.plugins.telescope then
          local builtin = require("telescope.builtin")
          builtin.type_definition()
        end
      end,
    })
  end, opts)
  map({ "n", "v" }, "ga", vim.lsp.buf.code_action, opts)
  map("n", "gD", vim.lsp.buf.declaration, opts)

  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
    map("n", "<leader>gi", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
    end, opts)
    -- client.server_capabilities.semanticTokensProvider = nil
  end
end

function M.setup(opts)
  M.opts = opts
  diagnostics.config_diagnostic(opts.diagnostic)

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client ~= nil then
        M.keymaps(client, ev.buf)

        if client:supports_method("textDocument/foldingRange") then
          local win = vim.api.nvim_get_current_win()
          vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
      end

      -- if client:supports_method("textDocument/documentColor") then
      --   vim.lsp.document_color.enable(true, buf)
      -- end

      -- local ok, navic = pcall(require, "nvim-navic")
      -- if ok and client.server_capabilities.documentSymbolProvider then
      --   navic.attach(client, buf)
      -- end
    end,
  })

  vim.lsp.enable(opts.lsp)
end

return M
