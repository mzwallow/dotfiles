return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				on_attach = function(buffer)
					local gitsigns = require("gitsigns")

					local map = function(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end, "Git: Next hunk")

					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end, "Git: Previous hunk")

					map("n", "<leader>hd", gitsigns.diffthis, "Git: Diff this")
					map("n", "<leader>hD", function()
						gitsigns.diffthis("~")
					end, "Git: Diff this")
				end,
			})
		end,
	},
}
