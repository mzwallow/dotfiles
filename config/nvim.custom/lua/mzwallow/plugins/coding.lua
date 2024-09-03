return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"onsails/lspkind.nvim",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			-- [[ Snippets ]]
			"saadparwaiz1/cmp_luasnip",
			-- [[ Buffer/Vim-builtin func ]]
			-- "hrsh7th/cmp-buffer",
			-- "hrsh7th/cmp-calc",
			-- [[ LSP ]]
			"hrsh7th/cmp-nvim-lsp",
			-- "hrsh7th/cmp-nvim-lsp-document-symbol",
			-- "hrsh7th/cmp-nvim-lsp-signature-help",
			-- [[ Miscellaneous ]]
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-cmdline",

			-- If you want to add a bunch of pre-configured snippets,
			--    you can use this plugin to help you. It even has snippets
			--    for various frameworks/libraries/etc. but you will have to
			--    set up the ones that are useful for you.
			-- 'rafamadriz/friendly-snippets',
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				sources = {
					-- [[ Snippets ]]
					{ name = "luasnip" },
					-- [[ Buffer/Vim-builtin func ]]
					-- { name = "buffer" },
					-- { name = "calc" },
					-- [[ LSP ]]
					{ name = "nvim_lsp" },
					-- { name = "nvim_lsp_document_symbol" },
					-- { name = "nvim_lsp_signature_help" },
					-- [[ Miscellaneous ]]
					{ name = "nvim_lua" },
					{ name = "path" },
					-- { name = "cmdline" },
					{ name = "lazydev", group_index = 0 },
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					expandable_indicator = true,
					format = function(entry, vim_item)
						if vim.tbl_contains({ "path" }, entry.source.name) then
							local icon, hl_group =
								require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
							if icon then
								vim_item.kind = icon
								vim_item.kind_hl_group = hl_group
								return vim_item
							end
						end
						return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
					end,
				},
			})
		end,
	},
}
