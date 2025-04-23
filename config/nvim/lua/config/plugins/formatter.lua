return {
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "goimports", "gci", "gofumpt" },
					rust = { "rustfmt" },
					python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
					typescript = { "prettierd" },
					yaml = { "prettierd" },
					json = { "prettierd" },
					jsonc = { "prettierd" },
					["*"] = { "trim_whitespace" },
					["_"] = { "trim_whitespace" },
				},
				formatters = {
					gci = {
						meta = {
							url = "https://github.com/daixiang0/gci",
							description = "GCI, a tool that controls Go package import order and makes it always deterministic.",
						},
						command = "gci",
						args = {
							"write",
							"--skip-generated",
							"--skip-vendor",
							"-s",
							"standard",
							"-s",
							"default",
							"-s",
							"localmodule",
							"$FILENAME",
						},
						stdin = false,
					},
				},
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
