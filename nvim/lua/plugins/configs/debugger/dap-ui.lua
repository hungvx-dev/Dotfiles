local M = {}

M.opts = {}

-- stylua: ignore
M.keys = {
  { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
  { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",   mode = { "n", "v" }, },
}

function M.setup(_)
  local dap, dapui = require("dap"), require("dapui")
  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M
