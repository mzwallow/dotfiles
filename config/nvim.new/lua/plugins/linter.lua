return {
  "mfussenegger/nvim-lint",
  event = {},
  config = function()
    require("lint").linters_by_ft = {
      lua = { "luacheck" },
      zig = { "zig" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      go = { "golangci-lint" },
      rust = { "clippy" },
      python = { "ruff" },
      html = { "htmlhint" },
      javascript = { "oxlint", "eslint_d" },
      typescript = { "oxlint", "eslint_d" },
      css = { "stylelint" },
      json = { "jsonlint" },
      jsonc = { "jsonlint" },
      yaml = { "yamllint" },
      toml = { "tombi" },
      sh = { "shellcheck" },
    }

    vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
