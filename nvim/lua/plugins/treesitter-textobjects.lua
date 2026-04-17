return {
  opts = {
    select = {
      lookahead = true,
      -- selection_modes = {
      --   ['@parameter.outer'] = 'v', -- charwise
      --   ['@function.outer'] = 'V', -- linewise
      --   ['@class.outer'] = '<c-v>', -- blockwise
      -- },
      include_surrounding_whitespace = false,
    },
  },
}
