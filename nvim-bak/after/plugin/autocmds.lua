local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
  return vim.api.nvim_create_augroup("hungvx_" .. name, { clear = true })
end

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank({ timeout = 300 })
  end,
  desc = "Highlight when yanking",
})

autocmd("FileType", {
  pattern = { "lua", "javascript", "typescript", "cpp", "rust", "go", "luau", "vue" },
  group = augroup("new_line_comment"),
  callback = function()
    vim.opt.formatoptions:remove({ "o" })
  end,
  desc = "Disable New Line Comment",
})

autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
  desc = "Equalize Splits",
})
