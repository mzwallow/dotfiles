return {
  "OXY2DEV/markview.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  ft = { "markdown", "Avante", "AvanteInput" },
  config = function()
    local presets = require("markview.presets")

    require("markview").setup({
      filetypes = { "markdown", "Avante", "AvanteInput" },
      max_length = 99999,
      checkboxes = presets.checkboxes.nerd,
    })
  end,
}
