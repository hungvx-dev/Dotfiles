---@diagnostic disable: undefined-field
local M = {}
local Extension = {}
local H = {}
local Cache = {}

function M.setup()
  _G.Statusline = M
  vim.o.laststatus = vim.g.st_laststatus
  M.extensions = {
    ["fzf"] = Extension.fzf.active,
    ["lazy"] = Extension.lazy.active,
    ["mason"] = Extension.mason.active,
    ["neo-tree"] = Extension.neotree.active,
    ["alpha"] = Extension.empty,
    ["help"] = Extension.empty,
    ["man"] = Extension.empty,
  }
  H.set_statusline()
  H.create_autocommands()
  vim.g.qf_disable_statusline = 1
end

function M.active()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo.filetype

  if not Cache[buf] then
    Cache[buf] = {}
  end

  if not Cache[filetype] then
    Cache[filetype] = {}
  end

  local extension = M.extensions[filetype]
  local args = { buf = buf, filetype = filetype }
  if extension ~= nil then
    return extension(args)
  end
  return H.default_content_active(args)
end

M.inactive = H.default_content_inactive

function M.combine_groups(groups)
  local parts = vim.tbl_map(function(s)
    if type(s) == "string" then
      return s
    end
    if type(s) ~= "table" then
      return ""
    end

    if s.strings:len() == 0 then
      return ""
    end

    if s.separator ~= nil then
      if s.separator.left_icon ~= nil then
        return table.concat({ "%#", s.hl, "# ", s.strings, "%#", s.separator.hl, "#", s.separator.left_icon })
      else
        return table.concat({ "%#", s.separator.hl, "#", s.separator.right_icon, "%#", s.hl, "# ", s.strings })
      end
    end

    return table.concat({ "%#", s.hl, "#", s.strings })
  end, groups)

  return table.concat(parts, "")
end

function M.is_truncated(trunc_width)
  local cur_width = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  return cur_width < (trunc_width or -1)
end

function M.section_mode()
  local mode_info = H.modes[vim.fn.mode()]
  return " ", mode_info.hl, mode_info.sep_hl
end

function M.section_git_branch(args)
  if M.is_truncated(args.trunc_width) then
    return ""
  end

  local repo_root = H.get_repo_root()
  if not repo_root then
    return ""
  end

  local cached = Cache[repo_root]
  if cached ~= nil then
    return cached ~= "" and args.icon .. cached or ""
  end

  local result = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { cwd = repo_root, text = true }):wait()

  local branch = (result.code == 0 and result.stdout) and vim.trim(result.stdout) or ""
  Cache[repo_root] = branch
  return branch ~= "" and args.icon .. branch or ""
end

M.diff_hl = {
  added = "%#GitSignsAdd#",
  changed = "%#GitSignsChange#",
  removed = "%#GitSignsDelete#",
}

function M.section_diff(args)
  if M.is_truncated(args.trunc_width) then
    return ""
  end
  local summary = vim.b.gitsigns_status_dict
  if summary == nil then
    return ""
  end
  local parts = {}
  for type, icon in pairs(args.diff) do
    local status = summary[type]

    if status and status > 0 then
      table.insert(parts, table.concat({ M.diff_hl[type], icon, status }))
    end
  end

  if #parts > 0 then
    return " " .. table.concat(parts, " ")
  end
  return ""
end

function M.section_lsp(args)
  if M.is_truncated(args.trunc_width) then
    return ""
  end
  return args.icon .. (Cache[args.filetype].lsp_attached or "-")
end

function M.section_encoding()
  local encoding = vim.bo.fileencoding or vim.bo.encoding

  local format = vim.bo.fileformat
  return string.format("%s %s", format, encoding)
end

function M.section_size(args)
  return args.icon .. H.get_filesize(args.buf)
end

function M.section_filetype(args)
  local filetype = args.filetype or vim.bo.filetype
  if Cache[filetype].type ~= nil then
    return Cache[filetype].type
  end

  if filetype ~= "" then
    local icon, hl = H.get_icon(filetype)
    Cache[filetype].type = table.concat({ " %#", hl, "#", icon, "%* ", filetype, " " })
  end

  return Cache[filetype].type or ""
end

function M.section_location()
  local buf = vim.api.nvim_get_current_buf()
  local win_id = vim.api.nvim_get_current_win()

  local total_lines = vim.api.nvim_buf_line_count(buf)
  local lw_cache = Cache[buf].line_width or { total = nil, width = nil }

  if lw_cache.total ~= total_lines then
    lw_cache.width = total_lines == 0 and 1 or math.max(2, math.floor(math.log10(total_lines)) + 1)
    lw_cache.total = total_lines
    Cache[buf].line_width = lw_cache
  end

  local sbar = H.get_sbar(buf, win_id)
  return string.format("%%P│%%2c:%%%dl▕%s▏", lw_cache.width, sbar)
end

function M.section_searchcount(args)
  if vim.v.hlsearch == 0 or M.is_truncated(args.trunc_width) then
    return ""
  end
  local ok, s_count = pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or s_count.current == nil or s_count.total == 0 then
    return ""
  end

  if s_count.incomplete == 1 then
    return "[?/?]"
  end

  local max = s_count.maxcount
  local function count(v)
    return v > max and ">" .. max or v
  end
  return table.concat({ "[", count(s_count.current), "/", count(s_count.total), "]" })
end

function M.section_maximized()
  return vim.t.is_maximized and HVIM.icons.UI.WindowMaximized or ""
end

function H.set_statusline()
  -- vim.o.statusline = "%{%v:lua.M.active()%}"
  vim.go.statusline = "%{%(&laststatus==3) ? v:lua.Statusline.active() : v:lua.Statusline.inactive()%}"
end

function H.create_autocommands()
  local gr = vim.api.nvim_create_augroup("M", {})
  local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc })
  end
  local track_lsp = vim.schedule_wrap(function(args)
    if vim.api.nvim_buf_is_valid(args.buf) then
      local is_redraw = H.compute_attached_lsp(vim.bo.filetype, args.buf)
      if is_redraw then
        vim.cmd("redrawstatus")
      end
    end
  end)
  au({ "LspAttach", "LspDetach" }, "*", track_lsp)

  local clean_cache = function(args)
    Cache[args.buf] = nil
    Cache[vim.bo.filetype] = nil
  end
  au("BufDelete", "*", clean_cache)
end

-- stylua: ignore start
H.modes = setmetatable({
  ['n']    = { hl = 'StModeNormal',  sep_hl = "StModeNormalSeparator" },
  ['v']    = { hl = 'StModeVisual',  sep_hl = "StModeVisualSeparator" },
  ['V']    = { hl = 'StModeVisual',  sep_hl = "StModeVisualSeparator" },
  ['s']    = { hl = 'StModeVisual',  sep_hl = "StModeVisualSeparator" },
  ['S']    = { hl = 'StModeVisual',  sep_hl = "StModeVisualSeparator" },
  ['i']    = { hl = 'StModeInsert',  sep_hl = "StModeInsertSeparator" },
  ['R']    = { hl = 'StModeReplace', sep_hl = "StModeReplaceSeparator" },
  ['c']    = { hl = 'StModeCommand', sep_hl = "StModeCommandSeparator" },
}, {
  __index = function()
    return   { hl = 'StModeDefault', sep_hl = "StModeDefaultSeparator" }
  end,
})
-- stylua: ignore end

function H.default_content_active(args)
  local mode, mode_hl, sep_hl = M.section_mode()
  local git_branch = M.section_git_branch({ trunc_width = 40, icon = HVIM.icons.Git.Branch })
  local diff = M.section_diff({ trunc_width = 75, diff = HVIM.git_line })
  local lsp = M.section_lsp({ trunc_width = 75, icon = " 󰰎 ", filetype = args.filetype })
  local filetype = M.section_filetype(args)
  local location = M.section_location()
  local search = M.section_searchcount({ trunc_width = 7 })
  local size = M.section_size({ icon = HVIM.icons.UI.Sd, buf = args.buf })
  local maximized = M.section_maximized()

  return M.combine_groups({
    { hl = mode_hl, strings = mode },
    { hl = "StBranchName", strings = git_branch, separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = "StBranchNameSeparator" } },
    diff,
    "%*",
    lsp,
    "%*%<%=",
    maximized,
    search,
    filetype,
    { hl = "StSectionY", strings = size, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = "StSectionYSeparator" } },
    { hl = mode_hl, strings = location, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = sep_hl } },
  })
end

function H.default_content_inactive()
  return "%#StatusLineNC#%F%="
end

function Extension.empty()
  return ""
end

Extension.fzf = {}
function Extension.fzf.active(args)
  local filetype = M.section_filetype(args)
  local picker = Extension.fzf.picker()
  return M.combine_groups({
    { hl = "StModeNormal", strings = "FZF", separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = "StSeparator" } },
    "%*%<",
    "%=",
    filetype,
    { hl = "StModeNormal", strings = picker, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = "StSeparator" } },
  })
end
function Extension.fzf.has()
  return pcall(require, "fzf-lua")
end
function Extension.fzf.picker()
  if not Extension.fzf.has() then
    return ""
  end

  local info_string = vim.inspect(require("fzf-lua").get_info()["fnc"])
  return info_string:gsub('"', "")
end

Extension.lazy = {}
function Extension.lazy.active(args)
  local filetype = M.section_filetype(args)
  local stats = Extension.lazy.stats()
  return M.combine_groups({
    { hl = "StModeNormal", strings = "Lazy", separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = "StSeparator" } },
    "%*%<",
    "%=",
    filetype,
    { hl = "StModeNormal", strings = stats, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = "StSeparator" } },
  })
end
function Extension.lazy.stats()
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    return ""
  end
  return "loaded: " .. lazy.stats().loaded .. "/" .. lazy.stats().count
end

Extension.mason = {}
function Extension.mason.active(args)
  local filetype = M.section_filetype(args)
  local registry = Extension.mason.registry()
  return M.combine_groups({
    { hl = "StModeNormal", strings = "Mason", separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = "StSeparator" } },
    "%*%<",
    "%=",
    filetype,
    { hl = "StModeNormal", strings = registry, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = "StSeparator" } },
  })
end
function Extension.mason.registry()
  local mason_registry
  local ok, registry = pcall(require, "mason-registry")
  if ok then
    mason_registry = registry
  end
  return "Installed: " .. #mason_registry.get_installed_packages() .. "/" .. #mason_registry.get_all_package_specs()
end
Extension.neotree = {}
function Extension.neotree.active(args)
  local filetype = M.section_filetype(args)
  local cwd = Extension.neotree.get_short_cwd({ trunc_width = 100 })
  return M.combine_groups({
    { hl = "StModeNormal", strings = "Neotree", separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = "StSeparator" } },
    "%*%<",
    "%=",
    filetype,
    { hl = "StModeNormal", strings = cwd, separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = "StSeparator" } },
  })
end

function Extension.neotree.get_short_cwd(args)
  if M.is_truncated(args.trunc_width) then
    return ""
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
end

function H.compute_attached_lsp(filetype, buf)
  if not Cache[filetype] then
    Cache[filetype] = {}
  end
  -- if Cache[filetype].lsp_attached == nil then
  local clients = vim.lsp.get_clients({ bufnr = buf })
  if clients == nil or not next(clients) then
    return nil
  end

  local attached = vim.tbl_map(function(client)
    -- print(client.name)
    return client.name or ""
  end, clients)
  Cache[filetype].lsp_attached = string.format("[%s]", table.concat(attached, ", "))
  --   return true
  -- end
  -- return false
end

function H.get_buf_lsp_clients(buf_id)
  return vim.lsp.get_clients({ bufnr = buf_id })
end

function H.get_icon(filetype)
  local MiniIcons = require("mini.icons")
  return MiniIcons.get("filetype", filetype)
end

function H.get_filesize(buf)
  if Cache[buf].size ~= nil then
    return Cache[buf].size
  end

  local size = math.max(vim.fn.line2byte(vim.fn.line("$") + 1) - 1, 0)
  if size < 1024 then
    Cache[buf].size = string.format("%dB ", size)
  elseif size < 1048576 then
    Cache[buf].size = string.format("%.2fKiB ", size / 1024)
  else
    Cache[buf].size = string.format("%.2fMiB ", size / 1048576)
  end

  return Cache[buf].size
end

H.chars = { "▔▔", "🭶🭶", "🭷🭷", "🭸🭸", "🭹🭹", "🭺🭺", "🭻🭻", "▁▁" }
function H.get_sbar(bufnr, win_id)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  win_id = win_id or vim.api.nvim_get_current_win()

  local cache = Cache[bufnr].sbar or { line = nil, total = nil, value = nil }
  local curr_line = vim.api.nvim_win_get_cursor(win_id)[1]
  local total_lines = math.max(vim.api.nvim_buf_line_count(bufnr), 1)

  if cache.line == curr_line and cache.total == total_lines then
    return cache.value
  end

  local ratio = (curr_line - 1) / total_lines
  local index = math.floor(ratio * #H.chars) + 1
  index = math.min(index, #H.chars)

  local result = H.chars[index] or " "

  Cache[bufnr].sbar = {
    line = curr_line,
    total = total_lines,
    value = result,
  }

  return result
end

function H.get_repo_root()
  if vim.env.GIT_DIR then
    return vim.env.GIT_DIR
  end

  local file_path = vim.api.nvim_buf_get_name(0)
  if file_path == "" then
    return nil
  end

  local git = vim.fs.find(".git", {
    upward = true,
    path = vim.fs.dirname(file_path),
    type = "directory",
    stop = vim.loop.os_homedir(),
  })

  if git[1] then
    return vim.fs.dirname(git[1])
  end

  return nil
end

return M
