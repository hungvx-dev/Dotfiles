local a = vim.api
local contains = vim.tbl_contains
local ffi = require("ffi")
ffi.cdef([[
  uint64_t display_tick;
  typedef struct {} Error;
  typedef struct {} win_T;
  typedef struct {
    int start;  int level;  int llevel;  int lines;
  } foldinfo_T;
  foldinfo_T fold_info(win_T* wp, int lnum);
  win_T *find_window_by_handle(int Window, Error *err);
  int compute_foldcolumn(win_T *wp, int col);
]])
local C = ffi.C
local error = ffi.new("Error")
local M = {}
local fold_cache = {}
local wp_cache = {}
local highlight = false

local flog_fold = {
  " ", -- 1: start
  " ", -- 2: start_branch
  "󰅂 ", -- 3: close_folded
  " ", -- 4: close
  "╰ ", -- 5: end
  "│ ", -- 6: sep
  " ", -- 7: end_branch
  " ", -- 8: virtual
  "  ", -- 9: eob
}

function M.is_level_one(lv, other_lv)
  return lv == 1 and (other_lv == 0 or other_lv == 1)
end

function M.update_fold_cache(win_id)
  if not fold_cache[win_id] then
    fold_cache[win_id] = {}
    wp_cache[win_id].tick = 0
  end
  local tick = C.display_tick
  if wp_cache[win_id].tick < tick then
    fold_cache[win_id] = {}
    wp_cache[win_id].tick = tick
  end
end

function M.get_window_handle(win_id)
  if wp_cache[win_id] then
    return wp_cache[win_id].wp
  end
  local wp = C.find_window_by_handle(win_id, error)
  if not wp then
    return nil
  end
  wp_cache[win_id] = { wp = wp, tick = 0 }
  return wp
end

function M.get_fold_info(win_id, lnum)
  local foldinfo = fold_cache[win_id][lnum] or C.fold_info(wp_cache[win_id].wp, lnum)
  fold_cache[win_id][lnum] = foldinfo
  return foldinfo
end

function M.folds()
  local win_id = vim.g.statusline_winid
  local wp = M.get_window_handle(win_id)
  if not wp then
    return ""
  end

  if C.compute_foldcolumn(wp, 0) == 0 then
    return ""
  end

  M.update_fold_cache(win_id)
  local lnum = vim.v.lnum
  local foldinfo = M.get_fold_info(win_id, lnum)
  local lv = foldinfo.level

  if lv == 0 then
    return flog_fold[9]
  end
  if vim.v.virtnum ~= 0 then
    if highlight then
      return table.concat({
        "%#FoldLevel_",
        lv,
        "#",
        flog_fold[8],
        "%*",
      })
    end
    return table.concat({ "%#FoldVirtual#", flog_fold[8], "%*" })
  end

  local before_foldinfo = M.get_fold_info(win_id, lnum - 1)
  local before_lv = before_foldinfo.level

  if foldinfo.lines > 0 then
    local fold = M.is_level_one(lv, before_lv) and flog_fold[3] or flog_fold[4]
    if highlight then
      return table.concat({ "%#FoldLevel_", lv, "#", fold, "%*" })
    end
    return table.concat({ "%#FoldClose#", fold, "%*" })
  end

  local fold = nil
  if foldinfo.start == lnum then
    fold = M.is_level_one(lv, before_lv) and flog_fold[1] or flog_fold[2]
  else
    local after_foldinfo = M.get_fold_info(win_id, lnum + 1)
    local after_lv = after_foldinfo.level
    if lv > after_lv then
      fold = after_lv == 0 and flog_fold[5] or flog_fold[7]
    elseif after_foldinfo.start > foldinfo.start and lv == after_lv then
      fold = M.is_level_one(lv, 0) and flog_fold[5] or flog_fold[7]
    else
      fold = flog_fold[6]
    end
  end

  if highlight then
    return table.concat({ "%#FoldLevel_", lv, "#", fold, "%*" })
  end
  return table.concat({ "%#FoldColumn#", fold, "%*" })
end

function M.statuscol()
  return "%s%l%=" .. M.folds()
end

function M.setup(opts)
  highlight = opts.highlight
  local id = vim.api.nvim_create_augroup("StatusCol", {})

  local stc = "%!v:lua.require('statuscol').statuscol()"
  a.nvim_set_option_value("stc", stc, { scope = "global" })
  for _, tab in ipairs(a.nvim_list_tabpages()) do
    for _, win in ipairs(a.nvim_tabpage_list_wins(tab)) do
      local buf = a.nvim_win_get_buf(win)
      if not contains(opts.ft_ignore, a.nvim_get_option_value("ft", { buf = buf })) and not contains(opts.bt_ignore or {}, a.nvim_get_option_value("bt", { buf = buf })) then
        a.nvim_set_option_value("stc", stc, { win = win })
      end
    end
  end
  a.nvim_create_autocmd("WinClosed", {
    group = id,
    callback = function(args)
      local win_id = tonumber(args.file)
      if win_id then
        wp_cache[win_id] = nil
        fold_cache[win_id] = nil
      end
    end,
  })

  a.nvim_create_autocmd("FileType", { group = id, pattern = opts.ft_ignore, command = "setlocal stc=" })
  a.nvim_create_autocmd("BufWinEnter", {
    group = id,
    callback = function()
      local win = a.nvim_get_current_win()
      local bt = a.nvim_get_option_value("bt", { scope = "local" })
      local ft = a.nvim_get_option_value("ft", { scope = "local" })
      local h = a.nvim_win_get_height(win)
      local w = a.nvim_win_get_width(win)
      if h <= 1 or w <= 10 or a.nvim_win_get_config(win).relative ~= "" then
        return
      end
      if contains(opts.ft_ignore, ft) or contains(opts.bt_ignore, bt) then
        a.nvim_set_option_value("stc", "", { scope = "local" })
        a.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      end
    end,
  })
  a.nvim_create_autocmd("OptionSet", {
    group = id,
    pattern = "buftype",
    callback = function()
      if contains(opts.bt_ignore, vim.v.option_new) then
        a.nvim_set_option_value("stc", "", { scope = "local" })
        a.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
      end
    end,
  })

  -- if opts.wrap then
  --   vim.api.nvim_create_autocmd("FileType", { group = id, pattern = opts.wrap, command = "setlocal stc=%s%l" })
  --   vim.api.nvim_set_option_value("foldcolumn", "0", { scope = "local" })
  -- end
end

return M
