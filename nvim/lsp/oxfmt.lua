local function root_markers_with_field(root_files, new_names, field, fname, match_mode)
  local path = vim.fn.fnamemodify(fname, ':h')
  local found = vim.fs.find(new_names, { path = path, upward = true, type = 'file' })
  local fields = type(field) == 'string' and { field } or field
  local to_find = vim.deepcopy(fields)
  local matcher = (match_mode or 'any') == 'any'
      and function(line)
        return vim.iter(fields):any(function(s) return line:find(s) end)
      end
    or function(line)
      to_find = vim.iter(to_find):filter(function(s) return not line:find(s) end):totable()
      if #to_find == 0 then
        to_find = vim.deepcopy(files)
        return true
      end
      return false
    end
  for _, f in ipairs(found or {}) do
    -- Match the given `field`.
    local file = assert(io.open(f, 'r'))
    for line in file:lines() do
      if matcher(line) then
        root_files[#root_files + 1] = vim.fs.basename(f)
        break
      end
    end
    file:close()
  end

  return root_files
end

local function insert_package_json(root_files, field, fname)
  return root_markers_with_field(root_files, { 'package.json', 'package.json5' }, field, fname)
end

return {
  cmd = function(dispatchers, config)
    local cmd = 'oxfmt'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--lsp' }, dispatchers)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'toml',
    'json',
    'jsonc',
    'json5',
    'yaml',
    'html',
    'vue',
    'handlebars',
    'css',
    'scss',
    'less',
    'graphql',
    'markdown',
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    -- Oxfmt resolves configuration by walking upward and using the nearest config file
    -- to the file being processed. We therefore compute the root directory by locating
    -- the closest `.oxfmtrc.json` / `.oxfmtrc.jsonc` / `oxfmt.config.ts` (or `package.json` fallback) above the buffer.
    local root_markers = insert_package_json(
      { '.oxfmtrc.json', '.oxfmtrc.jsonc', 'oxfmt.config.ts' },
      { 'oxfmt', 'vite%-plus' },
      fname
    )
    -- find vite plus config with fmt field
    root_markers = root_markers_with_field(root_markers, { 'vite.config.ts' }, { 'vite%-plus', 'fmt:' }, fname, 'all')
    on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
  end,
}
