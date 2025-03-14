return {
	{
		"mhartington/formatter.nvim",
		config = function()
			require("formatter").setup({
				filetype = {
					lua = { require("formatter.filetypes.lua").stylua },
					go = {
						require("formatter.filetypes.go").golines,
						require("formatter.filetypes.go").gofumpt,
					},
					rust = { require("formatter.filetypes.rust").rustfmt },
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					vim.api.nvim_create_autocmd("BufWritePost", {
						buffer = buffer,
						callback = function()
							vim.cmd("FormatWrite")
						end,
					})
				end,
			})
		end,
	},
}
