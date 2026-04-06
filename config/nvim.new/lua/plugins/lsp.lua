local lsp = {
  "lua_ls",
  "clangd",
  "gopls",
  "cssls",
  "jsonls",
  "yamlls",
  "tombi",
  "lemminx", -- xml
  "hyprls",
}
local tools = {
  "stylua",
  "clang-format",
  "cpplint",
  "nixfmt",
  "golangci-lint",
  "stylelint",
  "jsonlint",
  "yamllint",
  "xmlformatter",
  "prettierd",
}

---@module "lazy"
---@type LazySpec
return {
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    ---@module "mason-lspconfig"
    ---@type MasonLspconfigSettings
    opts = {
      automatic_enable = lsp,
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "b0o/schemastore.nvim",
    },
  },
  config = function()
    ---@module "mason-tool-installer"
    require("mason-tool-installer").setup({
      ensure_installed = vim.list_extend(lsp, tools),
      auto_update = true,
    })

    local Snacks = require("snacks")
    local map = Snacks.keymap
    local picker = Snacks.picker

    map.set("n", "grr", function()
      picker.lsp_references()
    end, { nowait = true, desc = "References" })

    map.set("n", "gd", function()
      picker.lsp_definitions()
    end, { desc = "Goto Definition" })

    map.set("n", "gD", function()
      picker.lsp_declarations()
    end, { desc = "Goto Declaration" })

    map.set("n", "gI", function()
      picker.lsp_implementations()
    end, { desc = "Goto Implementation" })

    map.set("n", "gy", function()
      picker.lsp_type_definitions()
    end, { desc = "Goto T[y]pe Definition" })

    map.set("n", "gai", function()
      picker.lsp_incoming_calls()
    end, { desc = "C[a]lls Incoming" })

    map.set("n", "gao", function()
      picker.lsp_outgoing_calls()
    end, { desc = "C[a]lls Outgoing" })

    map.set("n", "<leader>ss", function()
      picker.lsp_symbols()
    end, { desc = "LSP Symbols" })

    map.set("n", "<leader>sS", function()
      picker.lsp_workspace_symbols()
    end, { desc = "LSP Workspace Symbols" })
  end,
}
