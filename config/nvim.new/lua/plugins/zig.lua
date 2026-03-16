return {
  "https://codeberg.org/ziglang/zig.vim",
  config = function()
    vim.lsp.enable("zls")

    -- don't show parse errors in a separate window
    vim.g.zig_fmt_parse_errors = 0
    -- disable format-on-save from `ziglang/zig.vim`
    vim.g.zig_fmt_autosave = 0

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   group = vim.api.nvim_create_augroup("ZigCodeActions", { clear = true }),
    --   pattern = { "*.zig", "*.zon" },
    --   callback = function(args)
    --     vim.lsp.buf.code_action({
    --       context = {
    --         diagnostics = vim.diagnostic.get(args.buf),
    --         only = { "source.fixAll", "source.organizeImports" },
    --       },
    --       apply = true,
    --     })
    --
    --     require("conform").format()
    --   end,
    -- })
  end,
}
