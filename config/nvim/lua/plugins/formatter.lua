return {
	{
		"stevearc/conform.nvim",
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			log_level = vim.log.levels.DEBUG,
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = { timeout_ms = 500 },
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gci", "gofumpt" },
				rust = { lsp_format = "fallback" },
				python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
				c = { "clang-format" },
				asm = { "asmfmt" },
				tf = { "terraform_fmt" },
				hcl = { "packer_fmt", "terragrunt_hclfmt" },
				typescript = { "prettierd" },
				yaml = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				vue = { "prettierd" },
				svelte = { "prettierd" },
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
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
