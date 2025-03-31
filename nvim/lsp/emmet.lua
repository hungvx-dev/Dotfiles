---@type vim.lsp.Config
return {
	cmd = { "emmet-ls", "--stdio" },
	single_file_support = true,
	root_markers = { ".git" },
  filetypes = { "html", "typescriptreact", "vue", "javascriptreact", "css", "sass", "scss" },
	settings = {
		init_options = {
			jsx = {
				options = {
					["jsx.enabled"] = true,
					["markup.attributes"] = {
						["class"] = "className",
						["class*"] = "className",
						["for"] = "htmlFor",
					},
					["markup.valuePrefix"] = {
						["class*"] = "styles",
					},
				},
			},
		},
	},
}
