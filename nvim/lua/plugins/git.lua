return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = HVIM.plugins.git,
    version = "*",
    event = { "BufReadPost" },
    opts = {
      signs = {
        add = { text = HVIM.icons.UI.Line.BoldMid },
        change = { text = HVIM.icons.UI.Line.BoldMid },
        delete = { text = HVIM.icons.UI.Line.BoldMid },
        topdelete = { text = HVIM.icons.UI.Line.BoldMid },
        changedelete = { text = HVIM.icons.UI.Line.BoldMid },
        untracked = { text = HVIM.icons.UI.Line.BoldMid },
      },
      signs_staged = {
        add = { text = HVIM.icons.UI.Line.BoldMid },
        change = { text = HVIM.icons.UI.Line.BoldMid },
        delete = { text = HVIM.icons.UI.Line.BoldMid },
        topdelete = { text = HVIM.icons.UI.Line.BoldMid },
        changedelete = { text = HVIM.icons.UI.Line.BoldMid },
      },
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 200,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = " <author_mail> | <author_time:%R, %x> | <summary>",
      preview_config = {
        -- border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Navigation
        map("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end)

        map("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end)

        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>gb", function()
          gs.blame_line({ full = false })
        end)
      end,
    },
  },
  {
    "akinsho/git-conflict.nvim",
    enabled = HVIM.plugins.git,
    event = { "BufReadPost" },
    version = "*",
    config = true,
  },
  {
    "isakbm/gitgraph.nvim",
    enabled = false,
    opts = {
      symbols = {
        merge_commit = "",
        commit = " ",
        merge_commit_end = "",
        commit_end = "",

        -- Advanced symbols
        GVER = "",
        GHOR = "",
        GCLD = "",
        GCRD = "╭",
        GCLU = "",
        GCRU = "",
        GLRU = "",
        GLRD = "",
        GLUD = "",
        GRUD = "",
        GFORKU = "",
        GFORKD = "",
        GRUDCD = "",
        GRUDCU = "",
        GLUDCD = "",
        GLUDCU = "",
        GLRDCL = "",
        GLRDCR = "",
        GLRUCL = "",
        GLRUCR = "",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "author", "timestamp", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          print("selected commit:", commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print("selected range:", from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },
}
