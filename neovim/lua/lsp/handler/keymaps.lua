local Util = require "utils"
local M = {}

---@type PluginLspKeys
M._keys = nil

---@return ({has?:string})[]
function M.get()
  local format = require("lsp.handler.format").format
  if not M._keys then
    -- stylua: ignore
    ---@class PluginLspKeys
    M._keys = {
      { "!", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "gd", function() require("telescope.builtin").lsp_definitions { reuse_win = true } end, desc = "Goto Definition", has = "definition", },
      { "gi", function() require("telescope.builtin").lsp_implementations { reuse_win = true } end, desc = "Goto Implementation", },
      { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "gf", format, desc = "Format Document", has = "documentFormatting" },
      { "K", vim.lsp.buf.hover, desc = "Hover" },
      { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      {
        "ga",
        function()
          vim.lsp.buf.code_action({
            context = {
              only = {
                "source",
              },
              diagnostics = {},
            },
          })
        end,
        desc = "Source Action",
        has = "codeAction",
      },
      { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
      { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
      { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
      { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
      { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
      { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    }
    if Util.has "inc-rename.nvim" then
      M._keys[#M._keys + 1] = {
        "<leader>gr",
        function()
          require "inc_rename"
          return ":IncRename " .. vim.fn.expand "<cword>"
        end,
        expr = true,
        desc = "Rename",
        has = "rename",
      }
    else
      M._keys[#M._keys + 1] = { "<leader>gr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
  end
  return M._keys
end

---@param method string
function M.has(buffer, method)
  method = method:find "/" and method or "textDocument/" .. method
  local clients = Util.get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return (LazyKeys|{has?:string})[]
function M.resolve(buffer)
  local Keys = require "lazy.core.handler.keys"
  if not Keys.resolve then
    return {}
  end
  local spec = M.get()
  local opts = Util.opts "nvim-lspconfig"
  local clients = Util.get_clients { bufnr = buffer }
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require "lazy.core.handler.keys"
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    if not keys.has or M.has(buffer, keys.has) then
      local opts = Keys.opts(keys)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

function M.diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

return M
