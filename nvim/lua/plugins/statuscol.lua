local ffi = require("ffi")

ffi.cdef([[
  typedef struct {} Error;
  typedef struct {} win_T;
  typedef struct {
    int start;  // line number where deepest fold starts
    int level;  // fold level, when zero other fields are N/A
    int llevel; // lowest level that starts in v:lnum
    int lines;  // number of lines from v:lnum to end of closed fold
  } foldinfo_T;

  foldinfo_T fold_info(win_T* wp, int lnum);
  win_T *find_window_by_handle(int Window, Error *err);
  int compute_foldcolumn(win_T *wp, int col);
]])
local C = ffi.C
local error = ffi.new("Error")

local fold = {
  close = "󰅂 ",
  close1 = " ",
  open = "󰅀 ",
  open1 = " ",
  open2 = " ",
  eob = "  ",
  end_fold = "╰ ",
  sep = "│ ",
  branch = " ",
}
local function is_level_one(lv, other_lv)
  return lv == 1 and (other_lv == 0 or other_lv == 1)
end

local function folds()
  local wp = C.find_window_by_handle(vim.g.statusline_winid, error)
  if C.compute_foldcolumn(wp, 0) == 0 then
    return ""
  end

  local foldinfo = C.fold_info(wp, vim.v.lnum)
  local lv = foldinfo.level
  if lv == 0 then
    return ""
  end

  local before_foldinfo = C.fold_info(wp, vim.v.lnum - 1)
  local before_lv = before_foldinfo.level
  local icon

  if foldinfo.lines > 0 then
    icon = is_level_one(lv, before_lv) and fold.close or fold.close1
  elseif foldinfo.start == vim.v.lnum then
    icon = is_level_one(lv, before_lv) and fold.open1 or fold.open2
  else
    local after_foldinfo = C.fold_info(wp, vim.v.lnum + 1)
    local after_lv = after_foldinfo.level

    if lv > after_lv then
      icon = is_level_one(lv, after_lv) and fold.end_fold or fold.branch
    elseif after_foldinfo.start > foldinfo.start and lv == after_lv then
      icon = is_level_one(lv, 0) and fold.end_fold or fold.branch
    else
      icon = fold.sep
    end
  end

  if HVIM.highlight.fold then
    return "%#FoldLevel_" .. lv .. "#" .. icon .. "%*"
  end
  return "%#FoldColumn#" .. icon .. "%*"
end

if HVIM.highlight.fold then
  for i, color in ipairs(HVIM.ui.colors) do
    vim.api.nvim_set_hl(0, "FoldLevel_" .. i, { fg = color })
  end
  vim.wo.foldnestmax = #HVIM.ui.colors
end

function Statuscol()
  return table.concat({
    "%s",
    "%{v:relnum == 0?v:lnum:v:relnum}%=",
    folds(),
  })
end

return {
  {
    "statuscol",
    dev = true,
    -- enabled = false,
    lazy = false,
    opts = {
      ft_ignore = { "neo-tree", "alpha", "lazy", "help" },
      wrap = { "markdown" },
    },
    config = function(_, opts)
      local id = vim.api.nvim_create_augroup("StatusCol", {})
      if opts.ft_ignore then
        vim.wo.statuscolumn = "%!v:lua.Statuscol()"
        if opts.ft_ignore then
          vim.api.nvim_create_autocmd("FileType", { group = id, pattern = opts.ft_ignore, command = "setlocal stc=" })
          vim.api.nvim_create_autocmd("BufWinEnter", {
            group = id,
            callback = function()
              if vim.tbl_contains(opts.ft_ignore, vim.api.nvim_get_option_value("ft", { scope = "local" })) then
                vim.api.nvim_set_option_value("stc", "", { scope = "local" })
                vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
              end
            end,
          })
        end
      end
      if opts.wrap then
        vim.api.nvim_create_autocmd(
          "FileType",
          { group = id, pattern = opts.wrap, command = "setlocal stc=%s%{v:relnum==0?v:lnum:v:relnum}%=" }
        )
        vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      end
    end,
  },
}
