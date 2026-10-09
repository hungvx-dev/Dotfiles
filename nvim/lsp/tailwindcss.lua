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
        to_find = vim.deepcopy(fields)
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

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'tailwindcss-language-server'
    if (config or {}).root_dir then
      local local_cmd = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', cmd)
      if vim.fn.executable(local_cmd) == 1 then cmd = local_cmd end
    end
    return vim.lsp.rpc.start({ cmd, '--stdio' }, dispatchers)
  end,
  -- filetypes copied and adjusted from tailwindcss-intellisense
  filetypes = {
    'html',
    'css',
    -- 'javascript',
    'javascriptreact',
    -- 'typescript',
    'typescriptreact',
    'vue',
  },
  capabilities = {
    workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    },
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidScreen = 'error',
        invalidVariant = 'error',
        invalidConfigPath = 'error',
        invalidTailwindDirective = 'error',
        recommendedVariantOrder = 'warning',
      },
      classAttributes = {
        'class',
        'className',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        heex = 'phoenix-heex',
        htmlangular = 'html',
      },
      emmetCompletions = true,
      classFunctions = { 'tw', 'clsx', 'cva', 'cx' },
    },
  },
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend('keep', config.settings, {
      editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
    })
  end,
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local root_files = {
      -- Generic
      'tailwind.config.js',
      'tailwind.config.cjs',
      'tailwind.config.mjs',
      'tailwind.config.ts',
      'postcss.config.js',
      'postcss.config.cjs',
      'postcss.config.mjs',
      'postcss.config.ts',
      -- Django
      'theme/static_src/tailwind.config.js',
      'theme/static_src/tailwind.config.cjs',
      'theme/static_src/tailwind.config.mjs',
      'theme/static_src/tailwind.config.ts',
      'theme/static_src/postcss.config.js',
      -- Fallback for tailwind v4, where tailwind.config.* is not required anymore
      '.git',
    }
    local fname = vim.api.nvim_buf_get_name(bufnr)
    root_files = insert_package_json(root_files, 'tailwindcss', fname)
    root_files = root_markers_with_field(root_files, { 'mix.lock', 'Gemfile.lock' }, 'tailwind', fname)
    on_dir(vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1]))
  end,
}
