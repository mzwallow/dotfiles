return {
  {
    "chipsenkbeil/distant.nvim",
    branch = "v0.3",
    lazy = false,
    config = function()
      require("distant"):setup({
        manager = {
          user = true,
        },
      })
    end,
  },
}
