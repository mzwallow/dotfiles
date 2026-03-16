vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Sets how neovim will display certain whitespace in the editor.
opt.list = true
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Indentation
opt.softtabstop = -1
opt.smartindent = true

-- Display
opt.cursorline = true
opt.colorcolumn = "80"
opt.signcolumn = "yes"
opt.termguicolors = true
vim.wo.wrap = false

-- Split window in bottom right
opt.splitbelow = true
opt.splitright = true

-- Scroll
opt.scrolloff = 10

-- Search
opt.ignorecase = true
opt.smartcase = true

-- Preview substitutions live, as you type!
opt.inccommand = "split"

opt.clipboard = "unnamedplus"
opt.undofile = true

vim.keymap.set("n", "<leader><leader>", ":source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "p", { desc = "Copy replaced text" })
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Don't copy replaced text" })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR><esc>")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
