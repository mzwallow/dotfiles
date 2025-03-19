return {
	{
		"ray-x/go.nvim",
		build = ':lua require("go.install").update_all_sync()',
		ft = { "go", "gomod" },
		opts = {
			tag_options = "",
		},
	},
}
