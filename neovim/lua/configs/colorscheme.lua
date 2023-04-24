local c = require("tokyonight.colors").setup()

if vim.fn.has "nvim-0.8" then
  -- Ecovim Colors
  vim.api.nvim_set_hl(0, "EcovimPrimary", { fg = "#488dff" })
  vim.api.nvim_set_hl(0, "EcovimSecondary", { fg = "#FFA630" })

  vim.api.nvim_set_hl(0, "EcovimPrimaryBold", { bold = true, fg = "#488DFF" })
  vim.api.nvim_set_hl(0, "EcovimSecondaryBold", { bold = true, fg = "#FFA630" })

  vim.api.nvim_set_hl(0, "EcovimHeader", { bold = true, fg = "#488DFF" })
  vim.api.nvim_set_hl(0, "EcovimHeaderInfo", { bold = true, fg = "#FFA630" })
  vim.api.nvim_set_hl(0, "EcovimFooter", { bold = true, fg = "#FFA630" })
  -- Tokyonight Colorscheme Specific Config
  if hvim.colorscheme == "tokyonight-night" then
    -- Lines
    -- vim.api.nvim_set_hl(0, "CursorLineNR", { link = "EcovimSecondary" })
    -- vim.api.nvim_set_hl(0, "LineNr", { link = "Comment" })

    -- Floats/Windows
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "None", fg = "None" })
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "None" })
    -- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "None", fg = "#488DFF" })
    -- vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "None", fg = "#488DFF" })
    -- vim.api.nvim_set_hl(0, "BufferTabpageFill", { fg = "None" })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "None", fg = "#16161e" })
    vim.api.nvim_set_hl(0, "BqfPreviewBorder", { link = "FloatBorder" })

    -- Telescope
    vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "EcovimSecondary" })
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "None", fg = "None" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "None", fg = "#488DFF" })
    vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "EcovimSecondary" })

    -- Misc
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { link = "Comment" })
    -- vim.api.nvim_set_hl(0, "StatusLine", { bg = "None" })
    -- vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "None" })
    -- vim.api.nvim_set_hl(0, "rainbowcol1", { fg = c.blue, ctermfg = 9 })
    -- vim.api.nvim_set_hl(0, "Boolean", { fg = "#F7768E" })
    vim.api.nvim_set_hl(0, "BufferOffset", { link = "EcovimSecondary" })

    -- Completion Menu Colors
    local highlights = {
      CmpItemAbbr = { fg = c.dark3, bg = "NONE" },
      CmpItemKindClass = { fg = c.orange },
      CmpItemKindConstructor = { fg = c.purple },
      CmpItemKindFolder = { fg = c.blue2 },
      CmpItemKindFunction = { fg = c.blue },
      CmpItemKindInterface = { fg = c.teal, bg = "NONE" },
      CmpItemKindKeyword = { fg = c.magneta2 },
      CmpItemKindMethod = { fg = c.red },
      CmpItemKindReference = { fg = c.red1 },
      CmpItemKindSnippet = { fg = c.dark3 },
      CmpItemKindVariable = { fg = c.cyan, bg = "NONE" },
      CmpItemKindText = { fg = "LightGrey" },
      CmpItemMenu = { fg = "#e77ebf", bg = "NONE" },
      CmpItemAbbrMatch = { fg = "#569CD6", bg = "NONE" },
      CmpItemAbbrMatchFuzzy = { fg = "#569CD6", bg = "NONE" },
    }
    for group, hl in pairs(highlights) do
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end
-- END
--
-- vim.api.nvim_set_hl(0, "FloatShadow", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "FloatShadowThrough", { bg = "NONE" })
