local map = require("core.utils").map
local ls = require "luasnip"
require "custom.snippets.init"
-- Mappings

map("n", "<leader>s", ":HopWord <CR>")
map("n", "<leader>z", ":SymbolsOutline <CR>")
map("n", "<leader>w", ":w <CR>")
map("n", "<leader>q", ":q <CR>")
map("n", "<leader>qq", ":qa <CR>")

-- I never use q (recording, and it always get in the way, so bind it out)
map({ "n", "v" }, "q", "<nop>")

-- dont yank on change
map({ "n", "v" }, "c", '"_c')

-- reload snippets
map("n", "<leader>rs", "<cmd>source ~/.config/nvim/lua/custom/snippets/init.lua<CR>")

-- snippet keybind
-- TODO: replace with vim.keymap.set
local t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.snip_complete = function()
   if vim.fn.pumvisible() == 1 then
      return t "<C-n>"
   elseif ls.expand_or_jumpable() then
      return t "<Plug>luasnip-expand-or-jump"
   end
   return ""
end
_G.r_snip_complete = function()
   if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
   elseif ls.jumpable(-1) then
      return t "<Plug>luasnip-jump-prev"
   end
   return ""
end

vim.api.nvim_set_keymap("i", "<c-k>", "v:lua.snip_complete()", { expr = true, silent = true })
vim.api.nvim_set_keymap("s", "<c-k>", "v:lua.snip_complete()", { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-j>", "v:lua.r_snip_complete()", { expr = true, silent = true })
vim.api.nvim_set_keymap("s", "<c-j>", "v:lua.r_snip_complete()", { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-l>", "<Plug>luansip-next-choice", {})

-- Harpoon
vim.keymap.set({ "n" }, "<leader>a", function()
   require("harpoon.mark").add_file()
end, { silent = true })

vim.keymap.set({ "n" }, "<leader>hh", function()
   require("harpoon.ui").toggle_quick_menu()
end, { silent = true })

vim.keymap.set({ "n" }, "<leader>1", function()
   require("harpoon.ui").nav_file(1)
end, { silent = true })
vim.keymap.set({ "n" }, "<leader>2", function()
   require("harpoon.ui").nav_file(2)
end, { silent = true })
vim.keymap.set({ "n" }, "<leader>3", function()
   require("harpoon.ui").nav_file(3)
end, { silent = true })
vim.keymap.set({ "n" }, "<leader>4", function()
   require("harpoon.ui").nav_file(4)
end, { silent = true })

-- Played
vim.keymap.set({ "n" }, "<leader>tt", function()
   require("played").get_played()
end, { silent = true })
