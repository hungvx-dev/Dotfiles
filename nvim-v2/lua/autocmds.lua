-- vim.api.nvim_create_autocmd('BufWinEnter', {
--   pattern = '*',
--   callback = function()
--     if vim.bo.filetype == 'NvimTree' then
--       require'bufferline.api'.set_offset(31, 'FileTree')
--     end
--   end
-- })
--
-- vim.api.nvim_create_autocmd('BufWinLeave', {
--   pattern = '*',
--   callback = function()
--     if vim.fn.expand('<afile>'):match('NvimTree') then
--       require'bufferline.api'.set_offset(0)
--     end
--   end
-- })
--

-- Winbar (for nvim 0.8+)
if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost" }, {
    callback = function()
      local winbar_filetype_exclude = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "TelescopePrompt",
        "DressingInput",
        "DressingSelect",
        "neotest-summary",
      }

      if (vim.api.nvim_win_get_config(0).relative ~= "") then
        return
      end

      if vim.bo.filetype == 'toggleterm' then
        return
      end

      if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return
      end

      if vim.bo.filetype == 'GitBlame' then
        local hl_group = "EcovimSecondary"
        vim.opt_local.winbar = " " .. "%#" .. hl_group .. "#" .. require('icons').git .. "Blame" .. "%*"
        return
      end

      local winbar_present, winbar = pcall(require, "internal.winbar")
      if not winbar_present or type(winbar) == "boolean" then
        vim.opt_local.winbar = nil
        return
      end

      local value = winbar.gps()

      if value == nil then
        value = winbar.filename()
      end

      vim.opt_local.winbar = value
    end,
  })
end

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})
