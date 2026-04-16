local function root_markers_with_field(root_files, new_names, field, fname)
  local path = vim.fn.fnamemodify(fname, ":h")
  local found = vim.fs.find(new_names, { path = path, upward = true, type = "file" })

  for _, f in ipairs(found or {}) do
    local file = assert(io.open(f, "r"))
    for line in file:lines() do
      if line:find(field) then
        root_files[#root_files + 1] = vim.fs.basename(f)
        break
      end
    end
    file:close()
  end

  return root_files
end

local function insert_package_json(root_files, field, fname)
  return root_markers_with_field(root_files, { "package.json", "package.json5" }, field, fname)
end

return {
  cmd = function(dispatchers, config)
    local cmd = "oxfmt"
    local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/oxfmt"
    if local_cmd and vim.fn.executable(local_cmd) == 1 then
      cmd = local_cmd
    end
    return vim.lsp.rpc.start({ cmd, "--lsp" }, dispatchers)
  end,
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "toml",
    "json",
    "jsonc",
    "json5",
    "yaml",
    "html",
    "vue",
    "handlebars",
    "css",
    "scss",
    "less",
    "graphql",
    "markdown",
  },
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)

    local root_markers = insert_package_json({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, "oxfmt", fname)
    on_dir(vim.fs.dirname(vim.fs.find(root_markers, { path = fname, upward = true })[1]))
  end,
}
