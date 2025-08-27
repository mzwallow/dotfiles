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
					c = { "clang-format" },
					asm = { "asmfmt" },
					tf = { "terraform_fmt" },
					hcl = { "packer_fmt", "terragrunt_hclfmt" },
					yaml = { "prettierd" },
					json = { "prettierd" },
					jsonc = { "prettierd" },
					html = { "prettierd" },
					css = { "prettierd" },
					vue = { "prettierd" },
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
					packer_fmt = {
						meta = {
							url = "https://developer.hashicorp.com/packer/docs/commands/fmt",
							description = "The packer fmt Packer command is used to format HCL2 configuration files to a canonical format and style.",
						},
						command = "packer",
						args = { "fmt", "-", "write=true" },
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
