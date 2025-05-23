return {
	{
		"ggandor/leap.nvim",
		dependencies = "tpope/vim-repeat",
		config = function()
			require("leap").create_default_mappings()

			-- Define equivalence classes for brackets and quotes, in addition to
			-- the default whitespace group:
			require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

			-- Use the traversal keys to repeat the previous motion without
			-- explicitly invoking Leap:
			require("leap.user").set_repeat_keys("<enter>", "<backspace>")
		end,
	},
}
