-- local ls = require "luasnip"
local opt, g, fn = vim.opt, vim.g, vim.fn

-- vim opts
opt.belloff = "all"
opt.relativenumber = true
opt.encoding = "utf-8"
opt.splitkeep = "screen"

-- vim snippets
g.vscode_snippets_path = fn.stdpath("config") .. "/lua/custom/snippets"
g.lua_snippets_path = fn.stdpath("config") .. "/lua/custom/snippets"
g.go_term_mode = "vsplit"
g.go_term_enabled = 1

-- if using neovide
g.neovide_scale_factor = 0.8

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- temp
-- vim.lsp.set_log_level "debug" -- Sets the LSP log level to 'debug' for detailed logs

-- WSL clipboard
if vim.fn.has("wsl") == 1 then
	g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
		},
		cache_enabled = 0,
	}
end

-- Global funcs, utilities
local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

vim.api.nvim_create_user_command("RunGoTest", function()
	local ts_locals = require("nvim-treesitter.locals")
	local ts_utils = require("nvim-treesitter.ts_utils")
	local cursor_node = ts_utils.get_node_at_cursor()
	local scope = ts_locals.get_scope_tree(cursor_node, 0)
	local get_node_text = vim.treesitter.get_node_text
	local function_node, package_node
	local function_node_types = {
		function_declaration = true,
	}
	for _, v in ipairs(scope) do
		if function_node_types[v:type()] then
			function_node = v
		end
		if v:type() == "source_file" then
			package_node = v
		end
	end
	if not function_node then
		print("Not in a function")
		return
	end
	local package, function_name
	local packageQuery = vim.treesitter.query.parse("go", "(source_file (package_clause (package_identifier) @id))")
	local functionQuery = vim.treesitter.query.parse("go", "(function_declaration name: (_) @id)")
	for _, node in functionQuery:iter_captures(function_node, 0) do
		function_name = get_node_text(node, 0)
	end
	for _, node in packageQuery:iter_captures(package_node, 0) do
		package = get_node_text(node, 0)
	end
	local go_mod_path = vim.fn.findfile("go.mod", ".;")
	if go_mod_path == "" then
		print("go.mod not found in the directory tree")
		return
	end
	local go_mod_directory = vim.fn.fnamemodify(go_mod_path, ":h")
	local cmd = "gotest -v -count=1 ./.../" .. package .. " -run " .. function_name
	print(go_mod_directory)
	local term_buf = nil
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "terminal" then
			local job_id = vim.b[buf].terminal_job_id
			if vim.fn.jobwait({ job_id }, 0)[1] == -1 then -- Check if the job is still active
				term_buf = buf
				break
			end
		end
	end
	if term_buf then
		vim.cmd("buffer " .. term_buf)
		vim.cmd("startinsert")
		vim.fn.chansend(vim.b[term_buf].terminal_job_id, cmd .. "\n")
	else
		vim.cmd("vsplit term://" .. cmd)
	end
end, { nargs = "*" })

_G.run_command = function()
	local filetype = vim.bo.filetype
	if filetype == "c" then
		vim.cmd("!sh run.sh")
	end
	if filetype == "go" then
		run_make_dev()
	end
end

-- specific to whatever you're working on atm
_G.run_make_dev = function()
	-- Find the directory containing the Makefile
	local makefile_path = vim.fn.findfile("Makefile", ".")
	print("Rebuilding...")

	-- Check if Makefile is found
	if makefile_path ~= "" then
		-- Change to the directory containing the Makefile
		local makefile_dir = vim.fn.fnamemodify(makefile_path, ":h")
		vim.cmd("cd " .. makefile_dir)

		-- Kill previous process if running
		vim.fn.system("pkill -f marketpal_server")

		-- Run make dev
		vim.fn.jobstart("make dev", { detach = true })
		print("Dev is running.")
	else
		print("Makefile not found.")
	end
end

vim.api.nvim_create_user_command("DiffviewToggle", function(e)
	local view = require("diffview.lib").get_current_view()

	if view then
		vim.cmd("DiffviewClose")
	else
		vim.cmd("DiffviewOpen " .. e.args)
	end
end, { nargs = "*" })

_G.snip_complete = function()
	if fn.pumvisible() == 1 then
		return t("<C-n>")
	elseif require("luasnip").expand_or_jumpable() then
		return t("<Plug>luasnip-expand-or-jump")
	end
	return ""
end

_G.r_snip_complete = function()
	if fn.pumvisible() == 1 then
		return t("<C-p>")
	elseif require("luasnip").jumpable(-1) then
		return t("<Plug>luasnip-jump-prev")
	end
	return ""
end

function _G.smart_tab()
	return require("luasnip").expand_or_jumpable() and t("<Plug>luasnip-expand-or-jump") or t("<Tab>")
end

vim.keymap.set({ "n", "x", "o" }, "s", function()
	local current_window = vim.fn.win_getid()
	require("leap").leap({ target_windows = { current_window } })
end)
