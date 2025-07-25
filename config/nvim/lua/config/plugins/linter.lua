return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				go = { "golangcilint" },
				typescript = { "eslint_d" },
				c = { "cpplint" },
				tf = { "tflint", "terraform_validate" },
				js = { "eslint_d" },
				yaml = { "yamllint" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
				sh = { "shellcheck" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
