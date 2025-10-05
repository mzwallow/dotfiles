return {
	{
		"stevearc/oil.nvim",
		-- Optional dependencies
		dependencies = { "echasnovski/mini.icons", opts = {} },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		config = function()
			local detail = false

			require("oil").setup({
				win_options = {
					signcolumn = "no",
				},
				watch_for_changes = true,
				keymaps = {
					["<C-h>"] = false,
					["<C-j>"] = false,
					["<C-k>"] = false,
					["<C-l>"] = false,
					["gd"] = {
						desc = "Toggle file detail view",
						callback = function()
							detail = not detail
							if detail then
								require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
							else
								require("oil").set_columns({ "icon" })
							end
						end,
					},
				},
				view_options = { show_hidden = true },
			})
			vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		end,
	},
}
