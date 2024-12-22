require("nvchad.mappings")
-- Define key mappings using the new format
local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")

-- Save and redraw
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR><cmd>redraw<CR>", { desc = "Save and redraw" })

-- Navigation
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Previous search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true })
map("x", "N", "'nN'[v:searchforward]", { expr = true })
map("o", "n", "'Nn'[v:searchforward]", { expr = true })
map("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix" })

-- Quality of Life shortcuts
map("n", "<leader>s", ":%s/", { desc = "Substitute" })
map("n", "<leader>qa", ":qa!<CR>", { desc = "Quit all" })
map("n", "<leader>wa", ":wa<CR>", { desc = "Write all" })
map("n", "<leader>r", ":lua run_command()<CR>", { desc = "Run command" })

-- Plugin-specific mappings
map("n", "<leader>rt", ":lua require('neotest').run.run()<CR>", { desc = "Run Neotest" })
map("n", "<leader>gd", ":DiffviewToggle<CR>", { desc = "Toggle Diffview" })
map("n", "<leader>md", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
map("n", "<leader>zz", ":ZenMode<CR>", { desc = "Zen Mode" })
map("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP Restart" })
map("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP Info" })
map("n", "<leader>ms", ":Mason<CR>", { desc = "Open Mason" })
map("n", "<leader>e", ":lua MiniFiles.open()<CR>", { desc = "Open MiniFiles" })

-- Copilot mappings
map("i", "<C-;>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, {
	desc = "Copilot Accept",
	replace_keycodes = true,
	nowait = true,
	silent = true,
	expr = true,
	noremap = true,
})
map("n", "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")
map({ "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "x", "o" }, "S", "<Plug>(leap-backward)")

-- Don't yank on change
map("n", "c", '"_c', { desc = "Don't yank on change" })
map("n", "C", '"_C', { desc = "Don't yank on change" })
map("v", "c", '"_c', { desc = "Don't yank on change (visual mode)" })
map("v", "C", '"_C', { desc = "Don't yank on change (visual mode)" })

-- LSP key mappings
map("n", "<leader>ra", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename symbol" })
map("n", "<leader>ca", "<cmd>vim.lsp.buf.code_action()<CR>", { desc = "Code action" })
map("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })

-- Diagnostics navigation
map("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostics" })
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Previous diagnostic" })
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Next diagnostic" })

-- Fun mappings
map("n", "<leader>fml", ":CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
map("n", "<leader>fmg", ":CellularAutomaton game_of_life<CR>", { desc = "Game of Life" })

-- Telescope mappings
map("n", "<leader>fq", function()
	require("telescope.builtin").quickfix()
end, { desc = "Telescope Quickfix" })
map("n", "<leader>fj", function()
	require("telescope.builtin").jumplist()
end, { desc = "Telescope Jumplist" })
map("n", "<leader>fr", function()
	require("telescope.builtin").lsp_references()
end, { desc = "LSP References" })
map("n", "<leader>fs", function()
	require("telescope.builtin").lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })
map("n", "<leader>fc", function()
	require("telescope.builtin").command_history()
end, { desc = "Command History" })
map("n", "<leader>fi", function()
	require("telescope.builtin").lsp_implementations()
end, { desc = "LSP Implementations" })
map("n", "<leader>fv", function()
	require("telescope.builtin").find_files({
		shorten_path = false,
		cwd = "~/.config/nvim/lua/custom",
		prompt = "~ dotfiles ~",
		hidden = true,
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.55 },
		file_ignore_patterns = { "^node_modules/" },
	})
end, { desc = "Find dotfiles" })
map("n", "<leader>fw", function()
	local lga_actions = require("telescope-live-grep-args.actions")
	require("telescope").extensions.live_grep_args.live_grep_args({
		mappings = {
			i = {
				["<C-k>"] = lga_actions.quote_prompt({ postfix = " -t" }),
				["<C-g>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
			},
		},
		hidden = true,
		layout_strategy = "horizontal",
		layout_config = { preview_width = 0.55 },
		file_ignore_patterns = { "^node_modules/" },
	})
end, { desc = "Live grep with Telescope" })

-- Terminal in nvim
map("t", "<C-e>", "<Right>", { desc = "Navigate in terminal mode", noremap = true, silent = true })
