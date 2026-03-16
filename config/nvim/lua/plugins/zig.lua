return {
	{
		"https://codeberg.org/ziglang/zig.vim",
		ft = { "zig", "zon" },
		config = function()
			vim.lsp.log.set_level("trace")
			require("vim.lsp.log").set_format_func(vim.inspect)

			vim.g.zig_fmt_parse_errors = 0
			vim.g.zig_fmt_autosave = 0

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.zig", "*.zon" },
				callback = function()
					vim.lsp.buf.format()
				end,
			})

			vim.lsp.config("zls", {
				cmd = { os.getenv("HOME") .. "/lsp-wrapper/zls/zig-out/bin/zls" },
				filetypes = { "zig" },
				root_markers = { "build.zig" },
				settings = {},
			})
			vim.lsp.enable("zls")
		end,
	},
}
