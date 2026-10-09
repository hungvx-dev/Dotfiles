--- ```lua
--- vim.lsp.config('rust_glancer', {
---   init_options = {
---     diagnostics = {
---       onSave = true,
---     },
---   },
--- })
--- ```
--- set of options (`cfg`, `indexing`, `cargo`, `cache`, `diagnostics`).

---@type vim.lsp.Config
return {
  cmd = { 'rust-glancer', 'lsp' },
  filetypes = { 'rust' },
  -- rust-glancer rejects a Cargo workspace root that lies outside the LSP
  -- workspace folder it was given (see `is_workspace_root_allowed` in its
  -- source). The nearest-`Cargo.toml` default would land on a member crate's
  -- own manifest instead of the workspace root above it, so walk all the way
  -- up and prefer the outermost `Cargo.toml` that declares `[workspace]`.
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local manifests = vim.fs.find('Cargo.toml', { path = fname, upward = true, limit = math.huge })

    -- `manifests` is ordered nearest-to-farthest, so overwriting on every
    -- match (rather than stopping at the first one) keeps the farthest
    -- (outermost) `[workspace]` manifest.
    local workspace_root
    for _, manifest in ipairs(manifests) do
      local content = table.concat(vim.fn.readfile(manifest), '\n')
      if content:match('%[workspace%]') then workspace_root = vim.fs.dirname(manifest) end
    end

    on_dir(workspace_root or (manifests[1] and vim.fs.dirname(manifests[1])) or vim.fs.dirname(fname))
  end,
}
