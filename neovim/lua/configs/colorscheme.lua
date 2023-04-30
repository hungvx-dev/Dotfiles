local present, tokyonight = pcall(require, "tokyonight")
if not present then
  return
end

-- ╭──────────────────────────────────────────────────────────╮
-- │ Setup Colorscheme                                        │
-- ╰──────────────────────────────────────────────────────────╯
tokyonight.setup {
  style                    = "night",
  terminal_colors          = true,
  styles                   = {
    comments  = { italic = true },
    keywords  = { italic = true },
    functions = { italic = true },
    variables = "NONE",
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars  = "transparent",
    floats    = "transparent",
  },

  sidebars                 = {},
  hide_inactive_statusline = true,
  dim_inactive             = false,
  lualine_bold             = false,
  on_highlights            = function(hl, c)
    local prompt         = "#FFA630"
    local text           = "#488dff"
    local none           = "NONE"

    hl.TelescopeTitle    = { fg = prompt }
    hl.TelescopeNormal   = { bg = none, fg = none }
    hl.TelescopeBorder   = { bg = none, fg = text }
    hl.TelescopeMatching = { fg = prompt }

    -- hl.MsgArea                       = { fg = c.fg_dark }

    -- hl.NormalFloat.bg                = none
    -- hl.NormalSB.bg                   = none
    -- hl.FloatBorder.bg                = none
    -- hl.Pmenu.bg                      = none
    -- hl.BufferOffset                  = { fg = prompt }

    -- hl.NeoTreeNormal.bg              = none
    -- hl.NeoTreeNormalNC.bg            = none

    hl.StatusLine        = { bg = none }
    hl.StatusLineNC.bg   = none

    -- hl.TabLine.bg                    = none

    -- hl.TroubleNormal.bg              = none

    -- hl.LspFloatWinNormal.bg          = none
    -- hl.LspInfoBorder.bg              = none

    -- -- hl.CmpDocumentation.bg           = none
    -- -- hl.CmpDocumentationBorder.bg     = none
    -- -- hl.CmpItemAbbr.bg                = none
    -- -- hl.CmpItemMenu.bg                = none
    -- -- hl.CmpItemAbbrMatch.bg           = none
    -- -- hl.CmpItemAbbrMatchFuzzy.bg      = none
    -- -- hl.CmpItemKindVariable.bg        = none

    -- hl.CmpItemAbbr                   = { fg = c.dark3, bg = none }
    -- hl.CmpItemKindClass              = { fg = c.orange }
    -- hl.CmpItemKindConstructor        = { fg = c.purple }
    -- hl.CmpItemKindFolder             = { fg = c.blue2 }
    -- hl.CmpItemKindFunction           = { fg = c.blue }
    -- hl.CmpItemKindInterface          = { fg = c.teal, bg = none }
    -- hl.CmpItemKindKeyword            = { fg = c.magneta2 }
    -- hl.CmpItemKindMethod             = { fg = c.red }
    -- hl.CmpItemKindReference          = { fg = c.red1 }
    -- hl.CmpItemKindSnippet            = { fg = c.dark3 }
    -- hl.CmpItemKindVariable           = { fg = c.cyan, bg = none }
    -- hl.CmpItemKindText               = { fg = "LightGrey" }
    -- hl.CmpItemMenu                   = { fg = "#C586C0", bg = none }
    -- hl.CmpItemAbbrMatch              = { fg = "#569CD6", bg = none }
    -- hl.CmpItemAbbrMatchFuzzy         = { fg = "#569CD6", bg = none }

    -- hl.MiniStatuslineInactive.bg     = none
    -- hl.MiniTablineHidden.bg          = none
    -- hl.MiniTablineModifiedHidden.bg  = none
    -- hl.MiniTablineModifiedVisible.bg = none
    -- hl.MiniTablineTabpagesection.bg  = none
    -- hl.MiniTablineVisible.bg         = none
  end,
}

-- vim.api.nvim_set_hl(0, 'BufferTabpageFill', { fg = "None" });
-- vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { link = 'FloatBorder' })
