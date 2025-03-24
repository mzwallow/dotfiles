local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

g.have_nerd_font = true

-- Line numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in status line
opt.showmode = false
-- opt.laststatus = 3 -- global statusline

-- Sync clipboard between OS and Neovim.
opt.clipboard = "unnamedplus"

-- Show which line your cursor is on
opt.cursorline = true

-- Indenting
opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true

-- disable nvim intro
opt.shortmess:append("sI")

opt.splitbelow = true
opt.splitright = true
opt.undofile = true
opt.termguicolors = true

opt.hlsearch = false
opt.incsearch = true

opt.scrolloff = 10
opt.signcolumn = "yes"

opt.colorcolumn = "80"

-- Set completeopt to have a better completion experience
opt.completeopt = "menuone,noselect"

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250
opt.timeoutlen = 300

-- Sets how neovim will display certain whitespace in the editor.
vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-------------------------------------------------------------------------------
-- [[ Keymaps ]]
-------------------------------------------------------------------------------

---@param keys string
---@param func string | function
---@param desc string
local nmap = function(keys, func, desc)
	vim.keymap.set("n", keys, func, { desc = desc })
end

---@param keys string
---@param func string | function
---@param desc string
local vmap = function(keys, func, desc)
	vim.keymap.set("v", keys, func, { desc = desc })
end

-- General keymaps
nmap("<C-a>", "<cmd> %y+ <CR>", "Copy whole file")
vmap(">", ">gv", "")
vmap("<", "<gv", "")
vmap("J", ":m '>+1<CR>gv=gv", "")
vmap("K", ":m '<-2<CR>gv=gv", "")

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
vim.keymap.set("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

-- Diagnostic keymaps
nmap("[d", vim.diagnostic.goto_prev, "Go to previous [D]iagnostic message")
nmap("]d", vim.diagnostic.goto_next, "Go to next [D]iagnostic message")
nmap("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror message")
nmap("<leader>q", vim.diagnostic.setloclist, "Open diagnostic [Q]uicfix list")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
nmap("<C-h>", "<C-w><C-h>", "Move focus to the left window")
nmap("<C-l>", "<C-w><C-l>", "Move focus to the right window")
nmap("<C-j>", "<C-w><C-j>", "Move focus to the lower window")
nmap("<C-k>", "<C-w><C-k>", "Move focus to the upper window")
