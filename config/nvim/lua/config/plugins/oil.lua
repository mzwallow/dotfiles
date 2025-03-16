return {
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons", opts = {} },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				watch_for_changes = true,
				win_options = {
					signcolumn = "yes:2",
				},
				view_options = { show_hidden = true },
			})
			vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		end,
	},
}
