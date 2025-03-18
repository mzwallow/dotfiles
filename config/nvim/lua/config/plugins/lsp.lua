local servers = {
	"lua_ls",
	"gopls",
	"rust_analyzer",
	"yamlls",
	"spectral",
	"jsonls",
}

local tools = {
	"stylua",
	"golangci-lint",
	"golines",
	"goimports-reviser",
	"gofumpt",
	"yamllint",
	"jsonlint",
	"prettierd",
}

local ensure_installed = servers
vim.list_extend(ensure_installed, tools)

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
			"b0o/schemastore.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,
				["yamlls"] = function()
					require("lspconfig").yamlls.setup({
						settings = {
							yaml = {
								format = {
									enable = true,
									bracketSpacing = true,
								},
								validate = true,
								hover = true,
								completion = true,
								schemaStore = {
									enable = false,
									url = "",
								},
								schemas = require("schemastore").yaml.schemas({
									extra = {
										{
											name = "openapi3_0",
											description = "OpenAPI 3.0.X",
											fileMatch = { "**/*.openapi3_0.yml", "**/*.openapi3_0.yaml" },
											url =
											"https://raw.githubusercontent.com/stoplightio/spectral/refs/heads/develop/packages/rulesets/src/oas/schemas/oas/v3.0.json",
										},
									},
								}),
							},
						},
					})
				end,
				["jsonls"] = function()
					require("lspconfig").jsonls.setup({
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
					})
				end,
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

			local telescope_builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-]>", telescope_builtin.lsp_definitions)
			vim.keymap.set("n", "grr", telescope_builtin.lsp_references)
		end,
	},
}
