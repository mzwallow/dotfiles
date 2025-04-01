return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				go = { "golangcilint" },
				yaml = { "yamllint" },
				json = { "jsonlint" },
				sh = { "shellcheck" },
			}

			lint.linters.golangcilint.args = {
				"run",
				"--output.json.path=stdout",
				"--issues-exit-code=0",
				"--show-stats=false",
				"--output.text.print-issued-lines=false",
				"--output.text.print-linter-name=false",
				function()
					return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
				end,
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
