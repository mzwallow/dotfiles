return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				go = { "golangcilint" },
				typescript = { "oxlint" },
				js = { "oxlint" },
				c = { "cpplint" },
				tf = { "tflint", "terraform_validate" },
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
