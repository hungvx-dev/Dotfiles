---@diagnostic disable: undefined-field
local M = {}
local H = {}
local Extension = {}

-- ======================
-- Cache (weak table + LSP per-buffer)
-- ======================
local Cache = {
  buf = setmetatable({}, { __mode = 'v' }),
  ft = {},
  git = {},
}

-- ======================
-- Dependencies
-- ======================
local mini_icons = require('mini.icons')

-- ======================
-- Setup
-- ======================
function M.setup()
  _G.Statusline = M
  vim.o.laststatus = vim.g.st_laststatus or 3

  M.extensions = {
    ['fzf'] = Extension.fzf.active,
    ['lazy'] = Extension.lazy.active,
    ['mason'] = Extension.mason.active,
    ['neo-tree'] = Extension.neotree.active,
    ['alpha'] = Extension.empty,
    ['help'] = Extension.empty,
    ['man'] = Extension.empty,
    ['TelescopePrompt'] = Extension.empty,
  }

  H.set_statusline()
  H.create_autocommands()
  vim.g.qf_disable_statusline = 1
end

-- ======================
-- Core
-- ======================
function M.active()
  local buf = vim.api.nvim_get_current_buf()
  local filetype = vim.bo[buf].filetype

  Cache.buf[buf] = Cache.buf[buf] or {}
  Cache.ft[filetype] = Cache.ft[filetype] or {}

  local extension = M.extensions[filetype]
  if extension then return extension({ buf = buf, filetype = filetype }) end

  return H.default_content_active({ buf = buf, filetype = filetype })
end

M.inactive = H.default_content_inactive
-- ======================
-- Combine
-- ======================
function M.combine_groups(groups)
  local parts = {}

  for _, group in ipairs(groups) do
    if type(group) == 'string' then
      table.insert(parts, group)
      goto continue
    end

    if type(group) ~= 'table' or not group.strings or group.strings == '' then goto continue end

    local hl = group.hl or 'StatusLine'
    local sep = group.separator

    if sep and sep.left_icon then
      table.insert(parts, '%#' .. hl .. '# ' .. group.strings)
      table.insert(parts, '%#' .. sep.hl .. '#' .. sep.left_icon)
    elseif sep and sep.right_icon then
      table.insert(parts, '%#' .. sep.hl .. '#' .. sep.right_icon)
      table.insert(parts, '%#' .. hl .. '# ' .. group.strings)
    else
      table.insert(parts, '%#' .. hl .. '#' .. group.strings)
    end

    ::continue::
  end

  return table.concat(parts)
end

-- ======================
-- Utils
-- ======================
function M.section_mode()
  local mode_info = H.modes[vim.fn.mode()]
  return ' ', mode_info.hl, mode_info.sep_hl
end

-- ======================
-- Git
-- ======================
function M.section_git_branch(args)
  local buf = args.buf or vim.api.nvim_get_current_buf()
  local repo_root = H.get_repo_root(buf)

  if not repo_root then return '' end

  local cached = Cache.git[repo_root]
  if cached ~= nil then return cached ~= '' and args.icon .. cached or '' end

  Cache.git[repo_root] = ''

  vim.system({ 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }, {
    cwd = repo_root,
    text = true,
  }, function(result)
    local branch = (result.code == 0 and result.stdout) and vim.trim(result.stdout) or ''
    Cache.git[repo_root] = branch
    vim.schedule(vim.cmd.redrawstatus)
  end)

  return ''
end
-- ======================
-- Diff
-- ======================
M.diff_hl = {
  added = '%#GitSignsAdd#',
  changed = '%#GitSignsChange#',
  removed = '%#GitSignsDelete#',
}

function M.section_diff(args)
  local summary = vim.b.gitsigns_status_dict
  if not summary then return '' end

  local parts = {}
  local order = { 'added', 'changed', 'removed' }

  for _, typ in ipairs(order) do
    local count = summary[typ]
    if count and count > 0 then table.insert(parts, M.diff_hl[typ] .. args.diff[typ] .. count) end
  end

  return #parts > 0 and (' ' .. table.concat(parts, ' ')) or ''
end

-- ======================
-- LSP
-- Cache PER-BUFFER
-- ======================
function M.section_lsp(args)
  local ft_cache = Cache.ft[args.filetype] or {}
  return args.icon .. (ft_cache.lsp_attached or '-')
end

-- ======================
-- Other sections
-- ======================
function M.section_encoding()
  local encoding = vim.bo.fileencoding or vim.bo.encoding
  local format = vim.bo.fileformat
  return string.format('%s %s', format, encoding)
end

function M.section_size(args) return args.icon .. H.get_filesize(args.buf) end

function M.section_filetype(args)
  local filetype = args.filetype or vim.bo.filetype
  local ft_cache = Cache.ft[filetype]

  if ft_cache and ft_cache.type then return ft_cache.type end

  if filetype == '' then return '' end

  local icon, hl = H.get_icon(filetype)
  ft_cache = ft_cache or {}
  ft_cache.type = ' %#' .. hl .. '#' .. icon .. '%* ' .. filetype .. ' '
  Cache.ft[filetype] = ft_cache

  return ft_cache.type
end

function M.section_location()
  local buf = vim.api.nvim_get_current_buf()
  local win_id = vim.api.nvim_get_current_win()

  Cache.buf[buf] = Cache.buf[buf] or {}

  local total_lines = vim.api.nvim_buf_line_count(buf)
  local lw_cache = Cache.buf[buf].line_width or {}

  if lw_cache.total ~= total_lines then
    lw_cache.width = total_lines == 0 and 1 or math.max(2, math.floor(math.log10(total_lines)) + 1)
    lw_cache.total = total_lines
    Cache.buf[buf].line_width = lw_cache
  end

  local sbar = H.get_sbar(buf, win_id)
  return string.format('%%P│%%2c:%%%dl▕%s▏', lw_cache.width, sbar)
end

function M.section_searchcount(args)
  if vim.v.hlsearch == 0 or vim.o.cmdheight > 0 then return '' end

  local ok, s_count = pcall(vim.fn.searchcount, (args or {}).options or { recompute = true })
  if not ok or not s_count.current or s_count.total == 0 then return '' end

  if s_count.incomplete == 1 then return '[?/?]' end

  local max = s_count.maxcount
  local function count(v) return v > max and '>' .. max or v end

  return '[' .. count(s_count.current) .. '/' .. count(s_count.total) .. ']'
end

function M.section_maximized() return vim.t.is_maximized and HVIM.icons.UI.WindowMaximized or '' end

-- ======================
-- Statusline setup
-- ======================
function H.set_statusline()
  vim.go.statusline = '%{%(&laststatus==3) ? v:lua.Statusline.active() : v:lua.Statusline.inactive()%}'
end

-- ======================
-- Autocommands
-- ======================
function H.create_autocommands()
  local gr = vim.api.nvim_create_augroup('Statusline', { clear = true })

  local function au(event, callback) vim.api.nvim_create_autocmd(event, { group = gr, callback = callback }) end

  local track_lsp = vim.schedule_wrap(function(args)
    if vim.api.nvim_buf_is_valid(args.buf) then
      local redraw = H.compute_attached_lsp(vim.bo[args.buf].filetype, args.buf)
      if redraw then vim.cmd('redrawstatus') end
    end
  end)

  au({ 'LspAttach', 'LspDetach' }, track_lsp)

  au('BufDelete', function(args) Cache.buf[args.buf] = nil end)
end

-- ======================
-- Modes
-- ======================
H.modes = setmetatable({
  ['n'] = { hl = 'StModeNormal', sep_hl = 'StModeNormalSeparator' },
  ['v'] = { hl = 'StModeVisual', sep_hl = 'StModeVisualSeparator' },
  ['V'] = { hl = 'StModeVisual', sep_hl = 'StModeVisualSeparator' },
  ['i'] = { hl = 'StModeInsert', sep_hl = 'StModeInsertSeparator' },
  ['R'] = { hl = 'StModeReplace', sep_hl = 'StModeReplaceSeparator' },
  ['c'] = { hl = 'StModeCommand', sep_hl = 'StModeCommandSeparator' },
}, {
  __index = function() return { hl = 'StModeDefault', sep_hl = 'StModeDefaultSeparator' } end,
})

-- ======================
-- LSP compute
-- ======================
function H.compute_attached_lsp(filetype, buf)
  Cache.ft[filetype] = Cache.ft[filetype] or {}

  local clients = vim.lsp.get_clients({ bufnr = buf })
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end

  local new_value = #names > 0 and ('[' .. table.concat(names, ', ') .. ']') or '-'

  if Cache.ft[filetype].lsp_attached ~= new_value then
    Cache.ft[filetype].lsp_attached = new_value
    return true
  end
  return false
end

-- ======================
-- Helpers
-- ======================
function H.get_icon(filetype) return mini_icons.get('filetype', filetype) end

function H.get_filesize(buf)
  Cache.buf[buf] = Cache.buf[buf] or {}

  if Cache.buf[buf].size then return Cache.buf[buf].size end

  local size = math.max(vim.fn.line2byte(vim.fn.line('$') + 1) - 1, 0)

  if size < 1024 then
    Cache.buf[buf].size = string.format('%dB ', size)
  elseif size < 1048576 then
    Cache.buf[buf].size = string.format('%.2fKiB ', size / 1024)
  else
    Cache.buf[buf].size = string.format('%.2fMiB ', size / 1048576)
  end

  return Cache.buf[buf].size
end

H.chars = { '▔▔', '🭶🭶', '🭷🭷', '🭸🭸', '🭹🭹', '🭺🭺', '🭻🭻', '▁▁' }

function H.get_sbar(bufnr, win_id)
  Cache.buf[bufnr] = Cache.buf[bufnr] or {}

  local cache = Cache.buf[bufnr].sbar or {}
  local curr_line = vim.api.nvim_win_get_cursor(win_id)[1]
  local total_lines = math.max(vim.api.nvim_buf_line_count(bufnr), 1)

  if cache.line == curr_line and cache.total == total_lines then return cache.value end

  local ratio = (curr_line - 1) / total_lines
  local index = math.min(math.floor(ratio * #H.chars) + 1, #H.chars)

  local result = H.chars[index] or ' '

  Cache.buf[bufnr].sbar = {
    line = curr_line,
    total = total_lines,
    value = result,
  }

  return result
end

function H.get_repo_root(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  Cache.buf[buf] = Cache.buf[buf] or {}

  if Cache.buf[buf].repo_root ~= nil then return Cache.buf[buf].repo_root end

  local file_path = vim.api.nvim_buf_get_name(buf)
  if file_path == '' then
    Cache.buf[buf].repo_root = false
    return false
  end

  local git_dir = vim.fs.find('.git', {
    upward = true,
    path = vim.fs.dirname(file_path),
    limit = 1,
  })

  local root = git_dir[1] and vim.fs.dirname(git_dir[1]) or false
  Cache.buf[buf].repo_root = root
  return root
end

-- ======================
-- Default content
-- ======================
function H.default_content_active(args)
  local mode, mode_hl, sep_hl = M.section_mode()

  local git_branch = M.section_git_branch({
    icon = HVIM.icons.Git.Branch,
  })

  local diff = M.section_diff({
    diff = HVIM.git_line,
  })

  local lsp = M.section_lsp({
    icon = ' 󰰎 ',
    filetype = args.filetype,
  })

  local filetype = M.section_filetype(args)
  local location = M.section_location()
  local search = M.section_searchcount()
  local size = M.section_size({
    icon = HVIM.icons.UI.Sd,
    buf = args.buf,
  })
  local maximized = M.section_maximized()

  return M.combine_groups({
    { hl = mode_hl, strings = mode },

    {
      hl = 'StBranchName',
      strings = git_branch,
      separator = {
        left_icon = HVIM.icons.UI.Statusline.Left,
        hl = 'StBranchNameSeparator',
      },
    },

    diff,
    '%*',

    lsp,

    '%*%<%=',

    maximized,
    search,
    filetype,

    {
      hl = 'StSectionY',
      strings = size,
      separator = {
        right_icon = HVIM.icons.UI.Statusline.Right,
        hl = 'StSectionYSeparator',
      },
    },

    {
      hl = mode_hl,
      strings = location,
      separator = {
        right_icon = HVIM.icons.UI.Statusline.Right,
        hl = sep_hl,
      },
    },
  })
end

function H.default_content_inactive() return '%#StatusLineNC#%F%=' end

-- ======================
-- Extensions
-- ======================
function Extension.empty() return '' end

Extension.fzf = {}
function Extension.fzf.active(args)
  local filetype = M.section_filetype(args)
  local picker = Extension.fzf.picker()

  return M.combine_groups({
    {
      hl = 'StModeNormal',
      strings = 'FZF',
      separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = 'StSeparator' },
    },
    '%*%<',
    '%=',
    filetype,
    {
      hl = 'StModeNormal',
      strings = picker,
      separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = 'StSeparator' },
    },
  })
end

function Extension.fzf.has() return pcall(require, 'fzf-lua') end

function Extension.fzf.picker()
  if not Extension.fzf.has() then return '' end
  local info = require('fzf-lua').get_info()
  local fnc = info and info['fnc'] or ''
  return tostring(fnc):gsub('"', '')
end

Extension.lazy = {}
function Extension.lazy.active(args)
  local filetype = M.section_filetype(args)
  local stats = Extension.lazy.stats()

  return M.combine_groups({
    {
      hl = 'StModeNormal',
      strings = 'Lazy',
      separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = 'StSeparator' },
    },
    '%*%<',
    '%=',
    filetype,
    {
      hl = 'StModeNormal',
      strings = stats,
      separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = 'StSeparator' },
    },
  })
end

function Extension.lazy.stats()
  local ok, lazy = pcall(require, 'lazy')
  if not ok then return '' end
  local stats = lazy.stats()
  return 'loaded: ' .. stats.loaded .. '/' .. stats.count
end

Extension.mason = {}
function Extension.mason.active(args)
  local filetype = M.section_filetype(args)
  local registry = Extension.mason.registry()

  return M.combine_groups({
    {
      hl = 'StModeNormal',
      strings = 'Mason',
      separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = 'StSeparator' },
    },
    '%*%<',
    '%=',
    filetype,
    {
      hl = 'StModeNormal',
      strings = registry,
      separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = 'StSeparator' },
    },
  })
end

function Extension.mason.registry()
  local ok, registry = pcall(require, 'mason-registry')
  if not ok then return '' end
  return 'Installed: ' .. #registry.get_installed_packages() .. '/' .. #registry.get_all_package_specs()
end

Extension.neotree = {}
function Extension.neotree.active(args)
  local filetype = M.section_filetype(args)
  local cwd = Extension.neotree.get_short_cwd()

  return M.combine_groups({
    {
      hl = 'StModeNormal',
      strings = 'Neotree',
      separator = { left_icon = HVIM.icons.UI.Statusline.Left, hl = 'StSeparator' },
    },
    '%*%<',
    '%=',
    filetype,
    {
      hl = 'StModeNormal',
      strings = cwd,
      separator = { right_icon = HVIM.icons.UI.Statusline.Right, hl = 'StSeparator' },
    },
  })
end

function Extension.neotree.get_short_cwd() return vim.fn.fnamemodify(vim.fn.getcwd(), ':~') end

return M
