return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			-- require("mini.comment").setup()
			-- require("mini.pairs").setup()

			local indentscope = require("mini.indentscope")
			indentscope.setup()
			indentscope.gen_animation.none()

			require("mini.statusline").setup()
		end,
	},
}
