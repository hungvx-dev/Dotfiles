local M = {}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Key-mappings                                             │
-- ╰──────────────────────────────────────────────────────────╯
M.keys = {}
-- vim.keymap.set("n", "zR", require("ufo").openAllFolds)
-- vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
-- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
-- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)

function M.handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("  %d "):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

M.opts = {
  close_fold_kinds_for_ft = { "imports", "comment" },
  provider_selector = function()
    return { "treesitter", "indent" }
  end,
  fold_virt_text_handler = M.handler,
}

return M
