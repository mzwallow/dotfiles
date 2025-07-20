require("config.lazy")

--------------------------------------------------------------------------------
-- [[ Options ]]                                                               |
--------------------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2

-- Indentaion
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.smartindent = true
-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true

vim.opt.laststatus = 3
vim.opt.showmode = false     -- Don't show the mode, since it's already in status line
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

-- Split window in bottom right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim

vim.opt.undofile = true
-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Interval for writing swap file to disk, also used by gitsigns
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.wo.wrap = false

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 3

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
		vim.hl.on_yank()
	end,
})
