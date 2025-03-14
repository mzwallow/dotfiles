return {
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
		},
		version = "*",
		---@module "blink.cmp"
		---@type blink.cmp.Config
		opts = {
			completion = {
				menu = {
					draw = {
						treesitter = { "lsp" }
					},
				},
				documentation = { auto_show = true },
			},
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			sources = {
				-- add lazydev to your completion providers
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
			signature = { enabled = true }
		},
		opts_extend = { "sources.default" }
	}
}
