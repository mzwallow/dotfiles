return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    event = { "BufEnter" },
    config = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup({ n_lines = 200 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require("mini.surround").setup({
        mappings = {
          add = "<C-s>a", -- Add surrounding in Normal and Visual modes
          delete = "<C-s>d", -- Delete surrounding
          find = "<C-s>f", -- Find surrounding (to the right)
          find_left = "<C-s>F", -- Find surrounding (to the left)
          highlight = "<C-s>h", -- Highlight surrounding
          replace = "<C-s>r", -- Replace surrounding
          update_n_lines = "<C-s>n", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },
      })

      -- Autopairs
      require("mini.pairs").setup()

      -- Go forward/backward with square brackets
      require("mini.bracketed").setup({
        buffer = { suffix = "b", options = {} },
        comment = { suffix = "", options = {} },
        conflict = { suffix = "x", options = {} },
        diagnostic = { suffix = "", options = {} },
        file = { suffix = "", options = {} },
        indent = { suffix = "i", options = {} },
        jump = { suffix = "", options = {} },
        location = { suffix = "", options = {} },
        oldfile = { suffix = "", options = {} },
        quickfix = { suffix = "", options = {} },
        treesitter = { suffix = "t", options = {} },
        undo = { suffix = "", options = {} },
        window = { suffix = "", options = {} },
        yank = { suffix = "", options = {} },
      })

      -- Highlight patterns
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- [[ Statusline
      local statusline = require("mini.statusline")
      statusline.setup()

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
      -- ]]
    end,
  },
}
