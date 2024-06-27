return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 99
		-- vim.opt.foldlevelstart = 1
		vim.filetype.add({
			pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
		})

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			-- stylua: ignore
			ensure_installed = {
				"vim", "vimdoc", "lua", "luadoc",

				"html", "css", "javascript", "typescript", "tsx", "scss",
				"svelte", "vue",

				"go", "gomod", "gosum", "gotmpl", "gowork",
				"sql",

				"python", "dart",

				"gitcommit", "diff", "git_rebase", "gitignore",

				"markdown", "markdown_inline", "yaml", "json", "json5", "jsonc",
				"proto", "regex", "toml", "http", "make", "tsv",

				"comment", "bash", "dockerfile", "hyprlang", "ssh_config"
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
		parser_config.gotmpl = {
			install_info = {
				url = "https://github.com/ngalaiko/tree-sitter-go-template",
				files = { "src/parser.c" },
			},
			filetype = "gotmpl",
			used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
		}
	end,
}
