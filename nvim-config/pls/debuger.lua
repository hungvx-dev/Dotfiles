local debugger = require("plugins.configs.debugger")

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "codelldb",
        -- "node2",
        -- "chrome",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    enabled = HVIM.competitive_programming,
    dependencies = { "nvim-dap-ui" },
    keys = debugger.dap.keys,
    opts = debugger.dap.opts,
    config = debugger.dap.setup,
  },
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   enabled = HVIM.competitive_programming,
  --   dependencies = { "mason.nvim", "nvim-dap" },
  --   cmd = { "DapInstall", "DapUninstall" },
  --   opts = {
  --     -- automatic_installation = true,
  --     handlers = {},
  --     ensure_installed = {
  --       "codelldb",
  --       -- "node2",
  --       -- "chrome",
  --     },
  --   },
  -- },

  {
    "rcarriga/nvim-dap-ui",
    enabled = HVIM.competitive_programming,
    dependencies = { "nvim-neotest/nvim-nio" },
    keys = debugger.ui.keys,
    opts = {},
    -- config = debugger.ui.setup,
  },
}
