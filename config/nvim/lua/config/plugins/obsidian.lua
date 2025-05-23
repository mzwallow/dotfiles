return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/vault/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/vault/*.md",
		},
		config = function()
			vim.opt.conceallevel = 2

			require("obsidian").setup({
				workspaces = {
					{
						name = "vault",
						path = "~/vault",
					},
				},
			})
		end,
	},
}
