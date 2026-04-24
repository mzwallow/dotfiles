return {
  -- {
  --   "nvim-svelte/nvim-svelte-snippets",
  --   opts = {},
  -- },
  {
    "nvim-svelte/nvim-svelte-check",
    config = function()
      require("svelte-check").setup({
        command = "bun run check",
      })
    end,
  },
}
