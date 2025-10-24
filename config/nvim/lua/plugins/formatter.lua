return {
	{
		"stevearc/conform.nvim",
		---@module "conform"
		---@type conform.setupOpts
		opts = {},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
		config = function()
			require("conform").setup({
				log_level = vim.log.levels.TRACE,
				default_format_opts = { lsp_format = "fallback" },
				format_on_save = { timeout_ms = 2000 },
				formatters_by_ft = {
					lua = { "stylua" },
					go = { "golines", "goimports-reviser", "gci", "gofumpt" }, -- djlint
					rust = { "rustfmt", lsp_format = "fallback" },
					python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
					c = { "clang-format" },
					typescript = { "prettierd" },
					dart = { "dart_format" },
					asm = { "asmfmt" },
					tf = { "terraform_fmt" },
					hcl = { "packer_fmt", "terragrunt_hclfmt" },
					toml = { "tombi" },
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
					golines = {
						args = { "-m", "200" },
					},
					["goimports-reviser"] = {
						args = {
							"-format",
							"$FILENAME",
						},
					},
					gci = {
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
					},
					rust_fmt = {
						command = "rustfmt",
						options = {
							-- The default edition of Rust to use when no Cargo.toml file is found
							default_edition = "2024",
						},
						args = function(self, ctx)
							local args = { "--emit=stdout" }
							local edition = require("conform.util").parse_rust_edition(ctx.dirname) or self.options.default_edition
							table.insert(args, "--edition=" .. edition)
							table.insert(args, "--style-edition=" .. edition)

							return args
						end,
						cwd = require("conform.util").root_file({
							"rustfmt.toml",
							".rustfmt.toml",
						}),
					},
					dart_format = {
						command = "dart_format",
						args = { "$FILENAME" },
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
		end,
	},
}
