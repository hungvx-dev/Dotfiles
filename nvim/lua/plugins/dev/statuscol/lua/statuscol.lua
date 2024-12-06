if HVIM.highlight.fold then
  for i, color in ipairs(HVIM.ui.colors) do
    vim.api.nvim_set_hl(0, "FoldLevel_" .. i, { fg = color })
  end
  vim.wo.foldnestmax = #HVIM.ui.colors
end

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
local M = {}
local error = ffi.new("Error")

M.fold = {
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

function M.is_level_one(lv, other_lv)
  return lv == 1 and (other_lv == 0 or other_lv == 1)
end

function M.folds()
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
    icon = M.is_level_one(lv, before_lv) and M.fold.close or M.fold.close1
  elseif foldinfo.start == vim.v.lnum then
    icon = M.is_level_one(lv, before_lv) and M.fold.open1 or M.fold.open2
  else
    local after_foldinfo = C.fold_info(wp, vim.v.lnum + 1)
    local after_lv = after_foldinfo.level

    if lv > after_lv then
      icon = M.is_level_one(lv, after_lv) and M.fold.end_fold or M.fold.branch
    elseif after_foldinfo.start > foldinfo.start and lv == after_lv then
      icon = M.is_level_one(lv, 0) and M.fold.end_fold or M.fold.branch
    else
      icon = M.fold.sep
    end
  end

  if HVIM.highlight.fold then
    return "%#FoldLevel_" .. lv .. "#" .. icon .. "%*"
  end
  return "%#FoldColumn#" .. icon .. "%*"
end

function M.statuscol()
  return table.concat({
    "%s",
    "%{v:relnum == 0?v:lnum:v:relnum}%=",
    M.folds(),
  })
end

function M.setup(opts)
  local id = vim.api.nvim_create_augroup("StatusCol", {})
  if opts.ft_ignore then
    vim.wo.statuscolumn = "%!v:lua.require('statuscol').statuscol()"

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
end

return M
