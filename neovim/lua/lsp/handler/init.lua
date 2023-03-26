local utils = require("utils")
local format = require("lsp.handler.format")
local keymaps = require("lsp.handler.keymaps")

local M = {}

function M.setup()
  format.autoformat = true
  utils.on_attach(function(client, buffer)
    format.on_attach(client, buffer)
    keymaps.on_attach(client, buffer)
  end)
end

return M
