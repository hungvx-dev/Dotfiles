return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    exclude = {
      filetypes = {
        "lazy",
        "neo-tree",
        "mason",
        "help",
        "alpha",
        "dashboard",
        "Trouble",
        "trouble",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
    indent = { char = HVIM.icons.UI.Line.Left },
  },
}
