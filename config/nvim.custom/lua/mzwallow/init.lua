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
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>c_", hidden = true },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>d_", hidden = true },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>r_", hidden = true },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>s_", hidden = true },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>w_", hidden = true },
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
