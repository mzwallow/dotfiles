local M = {}

M.opts = {
  signs = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "┃" },
    change = { text = "┃" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "┆" },
  },
  signs_staged_enable = true,
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true,
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  on_attach = function(bufnr)
    local gitsigns = require("gitsigns")

    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, "Git: next hunk")

    map("n", "[c", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, "Git: prev hunk")

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, "Git: [H]unk [S]tage")
    map("n", "<leader>hr", gitsigns.reset_hunk, "Git: [H]unk [R]eset")
    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git: [H]unk [S]tage")
    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, "Git: [H]unk [R]eset")
    map("n", "<leader>hS", gitsigns.stage_buffer, "Git: [H]unk [S]tage buffer")
    map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Git: [H]unk [U]ndo stage")
    map("n", "<leader>hR", gitsigns.reset_buffer, "Git: [H]unk [R]eset buffer")
    map("n", "<leader>hp", gitsigns.preview_hunk, "Git: [H]unk [P]review")
    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, "Git: [H]unk [B]lame line")
    map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "Git: [T]oggle [B]lame line")
    map("n", "<leader>hd", gitsigns.diffthis, "Git: [H]unk [D]iff buffer")
    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end, "Git: [H]unk [D]iff HEAD~")
    map("n", "<leader>td", gitsigns.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
}

return M
