---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  ---@module "nvim-treesitter"
  config = function()
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
}
