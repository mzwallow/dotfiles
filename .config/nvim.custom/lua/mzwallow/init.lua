local plugins = {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	{ "numToStr/Comment.nvim", opts = {} },

	require("mzwallow.plugins.editor"),
	require("mzwallow.plugins.coding"),
	require("mzwallow.plugins.lsp"),
	require("mzwallow.plugins.treesitter"),

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
	},
}

local config = {
	defaults = { lazy = false },

	ui = {
		icons = vim.g.have_nerd_font and {} or {
			-- ft = "",
			-- lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
}

require("lazy").setup(plugins, config)
