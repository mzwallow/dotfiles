return {
	{
		"saghen/blink.compat",
		-- use the latest release, via version = '*', if you also use the latest release for blink.cmp
		version = "*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"Kaiser-Yang/blink-cmp-avante",
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
			"moyiz/blink-emoji.nvim",
		},
		version = "1.*",
		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			completion = {
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = { auto_show = true },
			},
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			sources = {
				default = {
					"lsp",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"avante",
					"emoji",
				},
				per_filetype = {
					lua = { inherit_defaults = true, "lazydev" },
					avante = { inherit_defaults = true, "avante" },
					sql = { "snippets", "dadbod", "buffer" },
				},
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
						opts = {},
					},
					dadbod = { module = "vim_dadbod_completion.blink", name = "Dadbod" },
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15,  -- Tune by preference
						opts = { insert = true }, -- Insert emoji (default) or complete its name
						should_show_items = function()
							return vim.tbl_contains(
							-- Enable emoji completion only for git commits and markdown.
							-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
				},
			},
			signature = { enabled = true },
		},
		opts_extend = { "sources.default" },
	},
}
