return {
	{
		"nvim-mini/mini.nvim",
		version = false,
		config = function()
			-- require("mini.comment").setup()
			require("mini.pairs").setup()

			-- require("mini.notify").setup()

			-- local indentscope = require("mini.indentscope")
			-- indentscope.setup()
			-- indentscope.gen_animation.none()

			require("mini.statusline").setup()

			-- statusline.setup({
			-- 	content = {
			-- 		active = function()
			-- 			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			-- 			local git = MiniStatusline.section_git({ trunc_width = 40 })
			-- 			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			-- 			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			-- 			local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			-- 			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			-- 			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			-- 			local location = MiniStatusline.section_location({ trunc_width = 75 })
			-- 			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
			--
			-- 			local lint_progress = function()
			-- 				local linters = require("lint").get_running()
			-- 				if #linters == 0 then
			-- 					return "󰦕"
			-- 				end
			-- 				return "󱉶 " .. table.concat(linters, ", ")
			-- 			end
			--
			-- 			return MiniStatusline.combine_groups({
			-- 				{ hl = mode_hl,                 strings = { mode } },
			-- 				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
			-- 				{ hl = mode_hl,                 strings = { lint_progress() } },
			-- 				"%<", -- Mark general truncate point
			-- 				{ hl = "MiniStatuslineFilename", strings = { filename } },
			-- 				"%=", -- End left alignment
			-- 				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
			-- 				{ hl = mode_hl,                  strings = { search, location } },
			-- 			})
			-- 		end,
			-- 	},
			-- })
		end,
	},
}
