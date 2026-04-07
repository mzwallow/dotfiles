---@module "lazy"
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install("all")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = require("nvim-treesitter").get_available(),
        callback = function()
          -- syntax highlighting, provided by Neovim
          vim.treesitter.start()
          -- folds, provided by Neovim
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
          vim.wo.foldcolumn = "0"
          vim.wo.foldlevel = 99
          vim.wo.foldnestmax = 3
          vim.opt.foldlevelstart = 99
          -- indentation, provided by nvim-treesitter
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ---@module "treesitter-context"
    ---@type TSContext.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      enable = true,
      multiwindow = true,
      max_lines = 3,
    },
  },
}
