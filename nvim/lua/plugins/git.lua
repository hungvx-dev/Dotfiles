return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = HVIM.plugins.git,
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
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 200,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = " <author_mail> | <author_time:%R, %x> | <summary>",
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

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
}
