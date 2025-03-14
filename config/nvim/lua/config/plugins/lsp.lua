local servers = {
	"lua_ls",
	"gopls",
}

local tools = {
	"golangci-lint",
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.tbl_deep_extend("force", servers, tools),
				auto_update = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					-- Format the current buffer on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
						end,
					})
				end,
			})
		end,
	},
}
