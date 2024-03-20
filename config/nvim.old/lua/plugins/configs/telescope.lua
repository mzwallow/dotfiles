local options = {
  defaults = {
    mappings = {
    },
  },
}

require("telescope").setup(options)

pcall(require("telescope").load_extension, "fzf")
