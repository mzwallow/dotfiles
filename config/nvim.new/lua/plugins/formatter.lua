---@module "lazy"
---@type LazySpec
return {
  "stevearc/conform.nvim",
  config = function()
    ---@module "conform"
    ---@type conform.setupOpts
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        zig = { "zigfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        go = { "golangci-lint", timeout_ms = 1500 },
        rust = { "rustfmt" },
        python = { "ruff" },
        nix = { "nixfmt" },
        html = { "prettierd" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        css = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        toml = { "tombi" },
        xml = { "xmlformatter" },
        sh = { "shfmt" },
        -- Use the "*" filetype to run formatters on all filetypes.
        ["*"] = { "trim_whitespace" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace" },
      },
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 500,
      },
      log_level = vim.log.levels.ERROR,
      notify_on_error = true,
      notify_no_formatters = true,
    })

    vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("FormatOnSave", { clear = true }),
      pattern = "*",
      callback = function()
        require("conform").format()
      end,
    })
  end,
}
