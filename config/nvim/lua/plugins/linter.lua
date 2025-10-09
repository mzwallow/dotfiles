return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				go = { "golangcilint" }, -- revive
				typescript = { "oxlint" },
				js = { "oxlint" },
				c = { "cpplint" },
				yaml = { "yamllint" },
				json = { "jsonlint" },
				jsonc = { "jsonlint" },
				sh = { "shellcheck" },
				tf = { "tflint", "terraform_validate" },
			}

			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
