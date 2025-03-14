-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"rebelot/kanagawa.nvim",
			priority = 1000, -- make sure to load this before all the other start plugins
			config = function()
				require("kanagawa").setup({
					theme = "dragon",
					background = {
						dark = "dragon",
					},
				})

				vim.cmd([[colorscheme kanagawa]])
			end,
		},
		-- import your plugins
		{ import = "config.plugins" },
		--[[
		{
			dir = "~/dotfiles/config/nvim/plugins/oilgit.nvim",
			dependencies = "stevearc/oil.nvim",
			config = function()
				require("oilgit").setup()
				vim.keymap.set("n", "<leader><leader>r", require("oilgit").setup)
			end
		},
		]] --
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
	change_detection = {
		enabled = false,
		notify = false,
	},
})
