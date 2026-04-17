local signs = {
  add = { text = HVIM.icons.UI.Line.BoldMid },
  change = { text = HVIM.icons.UI.Line.BoldMid },
  delete = { text = HVIM.icons.UI.Line.BoldMid },
  topdelete = { text = HVIM.icons.UI.Line.BoldMid },
  changedelete = { text = HVIM.icons.UI.Line.BoldMid },
  untracked = { text = HVIM.icons.UI.Line.BoldMid },
}

return {
  opts = {
    signs = signs,
    signs_staged = signs,
    signcolumn = true,

    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol',
      delay = 200,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = ' <author_mail> | <author_time:%R, %x> | <summary>',

    preview_config = {
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },

    on_attach = function(buffer)
      local gs = require('gitsigns')

      local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc }) end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gs.nav_hunk('next')
        end
      end, 'Git next hunk')

      map('n', '[h', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gs.nav_hunk('prev')
        end
      end, 'Git prev hunk')

      -- Actions
      map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Git Stage Hunk')
      map('n', '<leader>ghp', ':Gitsigns preview_hunk_inline<CR>', 'Git Preview Hunk')
      map('n', '<leader>ghd', gs.diffthis, 'Git Diff This')
      map('n', '<leader>gb', function() gs.blame_line({ full = false }) end, 'Git show blame')
    end,
  },
}
