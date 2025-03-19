return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports_reviser", "gofumpt" },
					rust = { "rustfmt" },
					yaml = { "prettierd" },
					json = { "prettierd" },
				},
				["*"] = { "trim_whitespace" },
				["_"] = { "trim_whitespace" },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = args.buf,
						callback = function()
							require("conform").format({ bufnr = args.buf })
						end,
					})
				end,
			})
		end,
	},
}
