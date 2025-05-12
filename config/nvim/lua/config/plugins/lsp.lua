local servers = {
	"lua_ls",
	"gopls",
	"rust_analyzer",
	"pyright",
	"ts_ls",

	"yamlls",
	"spectral",
	"jsonls",
	"bashls",
}

local tools = {
	-- Lua
	"stylua",
	-- Go
	"golangci-lint",
	"golines",
	"goimports",
	"gci",
	"gofumpt",
	-- Python
	"ruff",
	-- TS & JS
	"eslint_d",

	"yamllint",
	"jsonlint",
	"prettierd",
	-- Bash
	"shellcheck",
}

local ensure_installed = servers
vim.list_extend(ensure_installed, tools)

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"saghen/blink.cmp",
				dependencies = {
					"Kaiser-Yang/blink-cmp-avante",
				},
				opts = {
					keymap = { preset = "default" },
					sources = {
						default = { "avante", "lsp", "path", "snippets", "buffer" },
						providers = {
							avante = {
								module = "blink-cmp-avante",
								name = "Avante",
								opts = {},
							},
						},
					},
				},
			},
			"b0o/schemastore.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				auto_update = true,
			})

			vim.lsp.config("yamlls", {
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

			vim.lsp.config("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- Format the current buffer on save
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
						end,
					})

					-- Highlight references word under cursor
					if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = args.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = args.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
							callback = function(args2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = args2.buf })
							end,
						})
					end
				end,
			})

			local telescope_builtin = require("telescope.builtin")
			vim.keymap.set("n", "grr", telescope_builtin.lsp_references)
			vim.keymap.set("n", "gri", telescope_builtin.lsp_implementations)
		end,
	},
}
