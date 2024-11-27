return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("kanagawa").setup({
        theme = "dragon",
        background = {
          dark = "dragon",
        },
      })

      vim.cmd([[colorscheme kanagawa]])
    end,
  },

  { "numToStr/Comment.nvim", event = "BufEnter", opts = {} },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { "<A-i>", "<A-h>", "<A-v>" },
    config = function()
      local toggleterm = require("toggleterm")

      toggleterm.setup({
        open_mapping = [[<C-\>]],
      })

      vim.keymap.set("n", "<A-i>", function()
        toggleterm.toggle(1, nil, nil, "float", nil)
      end, { desc = "Terminal: Toggle float" })
      vim.keymap.set("n", "<A-h>", function()
        toggleterm.toggle(1, nil, nil, "horizontal", nil)
      end, { desc = "Terminal: Toggle horizontal" })
      vim.keymap.set("n", "<A-v>", function()
        toggleterm.toggle(1, 40, nil, "vertical", nil)
      end, { desc = "Terminal: Toggle vertical" })
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    event = { "BufEnter" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function()
        harpoon:list():add()
      end, { desc = "[H]arpoon: [A]dd" })
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon: 1" })
      vim.keymap.set("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon: 2" })
      vim.keymap.set("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon: 3" })
      vim.keymap.set("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon: 4" })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    event = "VimEnter",
    config = function()
      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("nvim-tree").setup({
        renderer = {
          highlight_modified = "icon",
          highlight_bookmarks = "icon",
          indent_markers = { enable = true },
          icons = {
            web_devicons = {
              folder = { enable = true },
            },
          },
        },
        update_focused_file = { enable = true },
        git = { enable = true },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
        },
        modified = { enable = true },
        filters = {
          git_ignored = false,
          custom = { "^.git$" },
        },
      })

      vim.keymap.set("n", "<Space>p", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvim tree" })
    end,
  },
}
