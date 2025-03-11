-- TODO: Make it realtime

local M = {}

local oil = require("oil")
local namespace = vim.api.nvim_create_namespace("oilgit")

---@class oilgit.status_detail
---@field index string
---@field working_tree string

---@class oilgit.highlight_groups
---@field hl_group string
---@field hl_group_link string

local codes = {
	[" "] = { "Unmodified", "" },
	["M"] = { "Modified", "DiffChange" },
	["T"] = { "TypeChanged", "DiffChange" },
	["A"] = { "Added", "DiffAdd" },
	["D"] = { "Deleted", "DiffDelete" },
	["R"] = { "Renamed", "DiffChange" },
	["C"] = { "Copied", "DiffAdd" },
	["U"] = { "Unmerged", "IncSearch" },
	["?"] = { "Untracked", "TermCursor" },
	["!"] = { "Ignored", "Conceal" },
}

---@param is_index boolean
---@param code string
---@return string
local highlight_group = function(is_index, code)
	local section = is_index and "Index" or "WorkingTree"
	return "OilGitStatus" .. section .. codes[code][1]
end

local set_highlight_groups = function()
	for key, value in pairs(codes) do
		local index_hl_group = highlight_group(true, key)
		local working_tree_hl_group = highlight_group(false, key)
		local hl_group_link = value[2]

		vim.api.nvim_set_hl(0, index_hl_group, { link = hl_group_link, default = true })
		vim.api.nvim_set_hl(0, working_tree_hl_group, { link = hl_group_link, default = true })
	end
end

---@param buffer integer
---@param out vim.SystemCompleted
local on_exit = function(buffer, out)
	if out.code == 0 and out.stdout then
		---@type table<string, oilgit.status_detail>
		local status = {}

		-- Extract status
		local status_lines = vim.split(out.stdout, "\n", { trimempty = true })
		for _, line in ipairs(status_lines) do
			local index_status_code = line:sub(1, 1)
			local working_status_code = line:sub(2, 2)
			local filename = line:sub(4)

			local dir_index = filename:find("/")
			if dir_index ~= nil then
				filename = filename:sub(1, dir_index - 1)

				if not status[filename] then
					status[filename] = {
						index = index_status_code,
						working_tree = working_status_code,
					}
				end
			else
				status[filename] = {
					index = index_status_code,
					working_tree = working_status_code,
				}
			end
		end

		if status then
			vim.api.nvim_buf_clear_namespace(buffer, namespace, 0, -1)

			for i = 1, vim.api.nvim_buf_line_count(buffer) do
				local entry = oil.get_entry_on_line(buffer, i)
				if entry and entry.name ~= ".." then
					local filename = entry.name
					local status_detail = status[filename]

					if status_detail then
						vim.api.nvim_buf_set_extmark(buffer, namespace, i - 1, 0, {
							priority = 2,
							sign_text = status_detail.index,
							sign_hl_group = highlight_group(true, status_detail.index),
						})
						vim.api.nvim_buf_set_extmark(buffer, namespace, i - 1, 0, {
							priority = 1,
							sign_text = status_detail.working_tree,
							sign_hl_group = highlight_group(false, status_detail.working_tree),
						})
					end
				end
			end
		end
	end
end

M.setup = function()
	print("oilgit reloaded")

	local augroup = vim.api.nvim_create_augroup("OilGitGroup", { clear = true })

	vim.api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "oil",
		callback = function(ft_callback_args)
			local buffer = ft_callback_args.buf

			if vim.b.oil_git_status_started then
				return
			end
			vim.b.oil_git_status_started = true

			vim.api.nvim_create_autocmd("BufLeave", {
				group = augroup,
				callback = function()
					vim.b.oil_git_status_started = false
				end
			})

			vim.api.nvim_create_autocmd("BufEnter", {
				buffer = buffer,
				callback = function(callback_args)
					local oil_url = callback_args.file
					local file_url = oil_url:gsub("^oil", "file")
					local path = vim.uri_to_fname(file_url)

					-- vim.schedule(function()
					local out = vim.system(
						{ "git", "status", ".", "--short", "--untracked", "--ignored" },
						{ cwd = path, text = true }
					):wait()

					on_exit(buffer, out)
					-- end)
				end
			})

			set_highlight_groups()
		end
	})
end

return M
