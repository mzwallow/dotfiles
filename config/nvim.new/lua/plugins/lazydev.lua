---@module "lazy"
---@type LazySpec
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  { -- optional blink completion source for require statements and module annotations
    "saghen/blink.cmp",
    version = "1.*",
    -- optional: provides snippets for the snippet source
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "bydlw98/blink-cmp-sshconfig",
        build = "make",
      },
    },
    opts_extend = { "sources.default" },
    ---@module "blink-cmp"
    ---@type blink.cmp.Config
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "sshconfig",
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
          sshconfig = {
            name = "SshConfig",
            module = "blink-cmp-sshconfig",
          },
        },
      },
      keymap = { preset = "default" },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },
}
