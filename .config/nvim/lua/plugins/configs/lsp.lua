require("mason").setup()
require("mason-lspconfig").setup()

require("neodev").setup()

local on_attach = function(_, bufnr)
  require("core.utils").load_mappings("lsp", { buffer = bufnr })
end

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { "missing-fields" } },
    },
  },

  -- Backend
  gopls = {},
  sqlls = {},

  -- Web
  html = {},
  cssls = {},
  tsserver = {},
  eslint = {},
  svelte = {},
  volar = {},
  tailwindcss = {},

  -- Data
  pyright = {},

  -- Misc
  jsonls = {},
  yamlls = {
    schemas = {
      ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.0/schema.json"] = "/*.{yml,yaml}"
    },
  },
  spectral = {},
  dockerls = {},
  docker_compose_language_service = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    })
  end,
})

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.impl,
    -- null_ls.builtins.code_actions.refactoring,

    -- Lint
    null_ls.builtins.diagnostics.gitlint,
    null_ls.builtins.diagnostics.trail_space,

    -- Go
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.diagnostics.golangci_lint,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.goimports_reviser,
    null_ls.builtins.formatting.golines,

    -- Python
    null_ls.builtins.formatting.autopep8,
  },
})
