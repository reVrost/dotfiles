require "nvchad.mappings"
-- Disable nvchad mappings
local nomap = vim.keymap.del

nomap("n", "<Tab>")
nomap("n", "<S-Tab>")
-- Define key mappings using the new format
local map = vim.keymap.set

-- General mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "jj", "<ESC>")
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer", silent = true })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer", silent = true })
map("n", "q", "<Nop>")
map("t", "<esc><esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Grapple mappings
map("n", "<leader>hh", "<cmd>Grapple toggle_tags<cr>", { desc = "Toggle tags menu", silent = true })
map("n", "<leader>a", "<cmd>Grapple toggle<cr>", { desc = "Tag a file", silent = true })
map("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { silent = true })
map("n", "<leader>2", "<cmd>Grapple select index=2<cr>", { silent = true })
map("n", "<leader>3", "<cmd>Grapple select index=3<cr>", { silent = true })
map("n", "<leader>4", "<cmd>Grapple select index=4<cr>", { silent = true })
map("n", "<leader>5", "<cmd>Grapple select index=5<cr>", { silent = true })
map("n", "<C-1>", "<cmd>Grapple tag index=1<cr>", { silent = true })
map("n", "<C-2>", "<cmd>Grapple tag index=2<cr>", { silent = true })
map("n", "<C-3>", "<cmd>Grapple tag index=3<cr>", { silent = true })
map("n", "<C-4>", "<cmd>Grapple tag index=4<cr>", { silent = true })
map("n", "<C-5>", "<cmd>Grapple tag index=5<cr>", { silent = true })

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
map("n", "<leader>rt", ":RunGoTest<CR>", { desc = "Run test" })
map({ "n", "t" }, "<leader>gs", ":GitTerminal<CR>", { desc = "Toggle git terminal", silent = true })
map("n", "<leader>gd", ":DiffviewToggle<CR>", { desc = "Toggle Diffview", silent = true })
map("n", "<leader>md", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
map("n", "<leader>zz", ":ZenMode<CR>", { desc = "Zen Mode" })
map("n", "<leader>lr", ":LspRestart<CR>", { desc = "LSP Restart" })
map("n", "<leader>li", ":LspInfo<CR>", { desc = "LSP Info", silent = true })
map("n", "<leader>ms", ":Mason<CR>", { desc = "Open Mason", silent = true })
map(
  "n",
  "<leader>e",
  "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>",
  { desc = "Open MiniFiles", silent = true }
)

-- Copilot mappings
-- map("i", "<C-;>", function()
--   vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
-- end, {
--   desc = "Copilot Accept",
--   replace_keycodes = true,
--   nowait = true,
--   silent = true,
--   expr = true,
--   noremap = true,
-- })
map("n", "s", "<Plug>(leap)")
map("n", "S", "<Plug>(leap-from-window)")
map({ "x", "o" }, "s", "<Plug>(leap-forward)")
map({ "x", "o" }, "S", "<Plug>(leap-backward)")

-- Don't yank on change
map({ "n", "v" }, "c", '"_c', { desc = "Don't yank on change" })
map({ "n", "v" }, "C", '"_C', { desc = "Don't yank on change" })

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

map({ "n", "x", "o" }, "s", function()
  local current_window = vim.fn.win_getid()
  require("leap").leap { target_windows = { current_window } }
end)

map("n", "<leader>b", '<cmd>lua require("dropbar.api").pick()<cr>', { desc = "dropbar: pick" })

-- FZF LUA test
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files({})<CR>", { desc = "FZF Files" })
map("n", "<leader>fq", "<cmd>lua require('fzf-lua').quickfix({})<CR>", { desc = "FZF Quickfix" })
map("n", "<leader>fr", "<cmd>lua require('fzf-lua').lsp_references({})<CR>", { desc = "FZF References" })
map("n", "<leader>fs", "<cmd>lua require('fzf-lua').lsp_live_workspace_symbols({})<CR>", { desc = "FZF Symbols" })
map("n", "<leader>fi", "<cmd>lua require('fzf-lua').lsp_implementations({})<CR>", { desc = "FZF Quickfix" })
map("n", "<leader>fw", "<cmd>lua require('fzf-lua').live_grep({})<CR>", { desc = "FZF Live Grep" })

-- Telescope mappings
-- map("n", "<leader>fq", function()
--   require("telescope.builtin").quickfix()
-- end, { desc = "Telescope Quickfix" })
map("n", "<leader>fj", function()
  require("telescope.builtin").jumplist()
end, { desc = "Telescope Jumplist" })
-- map("n", "<leader>fr", function()
--   require("telescope.builtin").lsp_references()
-- end, { desc = "LSP References" })
map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_workspace_symbols()
end, { desc = "Workspace Symbols" })
map("n", "<leader>fc", function()
  require("telescope.builtin").command_history()
end, { desc = "Command History" })
-- map("n", "<leader>fi", function()
--   require("telescope.builtin").lsp_implementations()
-- end, { desc = "LSP Implementations" })
map("n", "<leader>fv", function()
  require("telescope.builtin").find_files {
    shorten_path = false,
    cwd = "~/.config/nvim/lua",
    prompt = "~ dotfiles ~",
    hidden = true,
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
    file_ignore_patterns = { "^node_modules/" },
  }
end, { desc = "Find dotfiles" })
-- map("n", "<leader>fw", function()
--   local lga_actions = require "telescope-live-grep-args.actions"
--   require("telescope").extensions.live_grep_args.live_grep_args {
--     mappings = {
--       i = {
--         ["<C-k>"] = lga_actions.quote_prompt { postfix = " -t" },
--         ["<C-g>"] = lga_actions.quote_prompt { postfix = " --iglob " },
--       },
--     },
--     hidden = true,
--     layout_strategy = "horizontal",
--     layout_config = { preview_width = 0.55 },
--     file_ignore_patterns = { "^node_modules/" },
--   }
-- end, { desc = "Live grep with Telescope" })

-- Terminal in nvim
map("t", "<C-e>", "<Right>", { desc = "Navigate in terminal mode", noremap = true, silent = true })
