" hungvx.dev SuperVIM
lua require("configs.EcoVim")
"
runtime configs/01-settings.vim
runtime configs/02-key-maps.vim
runtime configs/03-autocmds.vim
runtime configs/04-highlight.vim
runtime configs/05-functions.vim

lua require("utils.globals")

lua require("configs.functions")
lua require("configs.lazy")
lua require("configs.autocmds")

lua require("lsp")
"
