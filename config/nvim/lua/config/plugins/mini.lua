return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			local statusline = require("mini.statusline")
			statusline.setup()
		end,
	},
}
