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
  before_init = function(_, config)
    config.settings = vim.tbl_deep_extend('keep', config.settings, {
      editor = { tabSize = vim.lsp.util.get_effective_tabstop() },
    })
  end,
  root_markers = {
    'package.json',
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
  },
  filetypes = {
    -- html
    'html',
    -- "markdown",
    -- "mdx",
    -- css
    'css',
    'less',
    'sass',
    'scss',
    -- js
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    -- mixed
    'vue',
  },
  settings = {
    tailwindCSS = {
      validate = true,
      lint = {
        cssConflict = 'error',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'error',
      },
      classAttributes = {
        'class',
        'className',
      },
      includeLanguages = {
        eelixir = 'html-eex',
        eruby = 'erb',
        templ = 'html',
        htmlangular = 'html',
      },
      emmetCompletions = true,
      classFunctions = { 'tw', 'clsx', 'cva', 'cx' },
    },
  },
}
