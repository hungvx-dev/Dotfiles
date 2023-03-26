local present, ufo = pcall(require, "ufo")
if not present then
  return
end
-- ╭──────────────────────────────────────────────────────────╮
-- │ Keymappings                                              │
-- ╰──────────────────────────────────────────────────────────╯
ufo.setup {
  close_fold_kinds = { "imports", "comment" },
}
