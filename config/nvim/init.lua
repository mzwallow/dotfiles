require("config.lazy")

--------------------------------------------------------------------------------
-- [[ Options ]]                                                               |
--------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

--------------------------------------------------------------------------------
-- [[ Keymaps ]]                                                               |
--------------------------------------------------------------------------------

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
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

--------------------------------------------------------------------------------
-- [[ Miscs ]]                                                                 |
--------------------------------------------------------------------------------

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
