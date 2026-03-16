return {
  "mfussenegger/nvim-lint",
  event = {},
  config = function()
    require("lint").linters_by_ft = {
      lua = { "stylua" },
      zig = { "zig" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      json = { "jsonlint" },
      yaml = { "yamllint" },
    }

    vim.api.nvim_create_autocmd({ "BufRead", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("Lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
