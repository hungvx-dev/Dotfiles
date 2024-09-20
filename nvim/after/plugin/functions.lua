function _G.foldtext()
  local line = vim.fn.getline(vim.v.foldstart)

  local line_count = vim.v.foldend - vim.v.foldstart + 1

  return "  󰁂 <" .. line .. ">  " .. line_count .. " lines"
end
