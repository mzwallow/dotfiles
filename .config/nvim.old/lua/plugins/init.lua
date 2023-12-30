local plugins = {

  "nvim-lua/plenary.nvim",

  -- [[ UI ]] --
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      require("core.utils").lazy_load("indent-blankline.nvim")
    end,
    opts = {},
    main = "ibl",
    config = function()
      require("plugins.configs.blankline")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    init = function()
      require("core.utils").lazy_load("lualine.nvim")
    end,
    opts = {},
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme onedark]])
    end,
  },

  -- [[ Git ]] --
  { "tpope/vim-fugitive", init = function() require("core.utils").lazy_load("vim-fugitive") end },
  { "tpope/vim-rhubarb",  init = function() require("core.utils").lazy_load("vim-rhubarb") end },
  { "tpope/vim-sleuth",   init = function() require("core.utils").lazy_load("vim-sleuth") end },
  {
    "lewis6991/gitsigns.nvim",
    ft = { "gitcommit", "diff" },
    init = function()
      -- Load gitsigns only when a git file is opened
      vim.api.nvim_create_autocmd({ "BufRead" }, {
        group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
        callback = function()
          vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
          if vim.v.shell_error == 0 then
            vim.api.nvim_del_augroup_by_name("GitSignsLazyLoad")
            vim.schedule(function()
              require("lazy").load({ plugins = { "gitsigns.nvim" } })
            end)
          end
        end,
      })
    end,
    config = function()
      require("plugins.configs.git")
    end,
  },

  -- [[ LSP ]] --
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      "nvimtools/none-ls.nvim",

      "folke/neodev.nvim",

      { "folke/trouble.nvim", opts = {} },
      "nvim-tree/nvim-web-devicons",

      { 'j-hui/fidget.nvim',  opts = {} },
    },
    init = function()
      require("core.utils").lazy_load("nvim-lspconfig")
    end,
    config = function()
      require("plugins.configs.lsp")
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    event = "InsertEnter",
    config = function()
      require("plugins.configs.cmp")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    build = ":TSUpdate",
    init = function()
      require("core.utils").lazy_load("nvim-treesitter")
    end,
    config = function()
      require("plugins.configs.treesitter")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },

  {
    'numToStr/Comment.nvim',
    keys = {
      { "gcc", mode = "n",          desc = "Comment toggle current line" },
      { "gc",  mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc",  mode = "x",          desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n",          desc = "Comment toggle current block" },
      { "gb",  mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb",  mode = "x",          desc = "Comment toggle blockwise (visual)" },
    },
    opts = {},
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },

  -- [[ File manager, Picker, etc ]] --
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings("telescope")
    end,
    config = function()
      require("plugins.configs.telescope")
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "antosha417/nvim-lsp-file-operations",
    },
    init = function()
      require("core.utils").load_mappings("nvimtree")
    end,
    config = function()
      require("plugins.configs.nvimtree")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm" },
    keys = {
      { "<C-\\>", mode = "n", desc = "Toggle terminal" },
    },
    config = function()
      require("plugins.configs.toggleterm")
    end,
  },

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  { "folke/neoconf.nvim", cmd = "Neoconf" },
  --[[ {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {},
    config = function()
      require("plugins.configs.noice")
    end,
  }, ]]

  {
    "folke/which-key.nvim",
    init = function()
      vim.opt.timeout = true
      vim.opt.timeoutlen = 300
      require("core.utils").load_mappings("whichkey")
      require("core.utils").lazy_load("which-key.nvim")
    end,
    opts = {},
    config = function()
      require("plugins.configs.whichkey")
    end,
  },
}

require("lazy").setup(plugins, require("plugins.configs.lazy"))
