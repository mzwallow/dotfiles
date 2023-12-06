local M = {}

M.general = {

  i = {
    -- Go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- Navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<leader>"] = { "<Nop>", opts = { silent = true } },
    ["<leader>ex"] = { vim.cmd.Ex, "[E][x]plorer", },
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },

    ["J"] = { "mzJ`z" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },

    -- Move between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- Remap for dealing with word wrap
    ["k"] = { "v:count == 0 ? 'gk' : 'k'", "Move up", opts = { expr = true, silent = true } },
    ["j"] = { "v:count == 0 ? 'gj' : 'j'", "Move down", opts = { expr = true, silent = true } },

    -- Diagnostic
    ["[d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic message" },
    ["]d"] = { vim.diagnostic.goto_next, "Go to next diagnostic message" },
    ["<leader>e"] = { vim.diagnostic.open_float, "Open floating diagnostic message" },
    ["<leader>q"] = { vim.diagnostic.setloclist, "Open diagnostic list" },
  },

  v = {
    ["<leader>"] = { "<Nop>", opts = { silent = true } },

    ["J"] = { ":m '>+1<CR>gv=gv" },
    ["K"] = { ":m '<-2<CR>gv=gv" },
  },

  x = {
    ["<leader>p"] = { [["_dP]] },
  },
}

M.telescope = {
  plugin = true,

  n = {
    -- Find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "[F]ind [F]iles" },
    ["<leader>fg"] = { "<cmd> Telescope live_grep <CR>", "[F] by [G]rep" },
    ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "[F]ind [B]uffers" },
    ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "[F]ind [O]ldfiles" },
    ["<leader>f/"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "[F]ind in current buffer[/]" },
    ["<leader>gf"] = { "<cmd> Telescope git_files <CR>", "Find [G]it [F]iles" },

    -- Git
    ["<leader>gcm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
    ["<leader>gst"] = { "<cmd> Telescope git_status <CR>", "Git status" },
  },
}

M.whichkey = {
  plugin = true,

  n = {
    --["<leader>"] = { "<cmd> WhichKey <CR>", "which-key all keymaps" }
  },
}

M.lsp = {
  plugin = true,

  n = {
    ["<leader>rn"] = { function() vim.lsp.buf.rename() end, "LSP: [R]e[n]ame" },
    ["<leader>ca"] = { function() vim.lsp.buf.code_action() end, "LSP: [C]ode [A]ction" },

    ["gd"] = { function() vim.lsp.buf.definition() end, "LSP: [G]o to [D]ifinition" },
    ["gr"] = { function() vim.lsp.buf.references() end, "LSP: [G]o to [R]eferences" },
    ["gi"] = { function() vim.lsp.buf.implementation() end, "LSP: [G]o to [I]mplementation" },

    ["K"] = { function() vim.lsp.buf.hover() end, "LSP: Hover Documentation" },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = true })
      end,
      "LSP: Formatting",
    },
  },

  i = {
    ["<C-S-i>"] = { vim.lsp.buf.signature_help },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    ["<leader>hp"] = { require("gitsigns").preview_hunk, "Preview git hunk" },

    -- don't override the built-in and fugitive keymaps
    ["]c"] = {
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return '<Ignore>'
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return '<Ignore>'
      end,
      "Jump to previous hunk",
      opts = { expr = true },
    },
  },

  v = {
    -- don't override the built-in and fugitive keymaps
    ["]c"] = {
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return '<Ignore>'
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },
    ["[c"] = {
      function()
        if vim.wo.diff then
          return '[c'
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return '<Ignore>'
      end,
      "Jump to previous hunk",
      opts = { expr = true },
    },
  },
}

return M
