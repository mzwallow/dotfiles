return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    event = "BufEnter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        "query", -- Tree-Sitter query language
        "vim",
        "vimdoc",
        "lua",
        "luadoc",

        -- Text
        "comment",
        "csv",
        "tsv",
        "diff",
        "make",
        "markdown",
        "markdown_inline",
        "regex",
        "json",
        "jsonc",
        "proto",
        "yaml",
        "toml",

        -- Web
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "svelte",
        "vue",

        -- Git
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        -- [[ Languages
        -- Go
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",

        -- Godot
        "gdscript",
        "gdshader",
        "godot_resource",

        "bash",
        "c",
        "c_sharp",
        "cpp",
        "dart",
        "python",
        "rust",
        "sql",
        "zig",
        -- ]]

        -- [[ Others
        "dockerfile",
        "hyprlang",
        "ssh_config",
        "tmux",
        -- ]]
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
    opts = {},
  },
}
