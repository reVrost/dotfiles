local map = require("core.utils").map
local ls = require "luasnip"
local opt = vim.opt
require "custom.snippets.init"

-- vim opts
opt.belloff = "all"

-- Set nohl after confirm search
-- local group = vim.api.nvim_create_augroup("reVrost", { clear = false })
-- vim.api.nvim_create_autocmd({ "InsertEnter" }, {
--    group = group,
--    callback = function()
--       if vim.v["hlsearch"] == 1 then
--          vim.api.nvim_feedkeys(":nohl\n", "m", false)
--          -- vim.api.nvim_set_var("hlsearch", 0)
--          -- vim.cmd "nohl"
--       else
--          print "noop"
--       end
--    end,
-- })

-- Mappings

-- map is the same as vim.api.nvim_setkeymap
-- But it overrides the nvchad keymap table
map("n", "<leader>s", ":HopWord <CR>")
map("n", "<leader>z", ":SymbolsOutline <CR>")
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
vim.keymap.set({ "n" }, "<leader>5", function()
   require("harpoon.ui").nav_file(5)
end, { silent = true })
vim.keymap.set({ "n" }, "<leader>6", function()
   require("harpoon.ui").nav_file(6)
end, { silent = true })
vim.keymap.set({ "n" }, "<leader>7", function()
   require("harpoon.ui").nav_file(7)
end, { silent = true })

-- Played
vim.keymap.set("n", "<leader>tt", function()
   require("played").get_played()
end, { silent = true })

-- Telescope
local tele = require "telescope.builtin"
local edit_neovim = function()
   require("telescope.builtin").find_files {
      shorten_path = false,
      cwd = "~/.config/nvim/lua/custom/",
      prompt = "~ dotfiles ~",
      hidden = true,

      layout_strategy = "horizontal",
      layout_config = {
         preview_width = 0.55,
      },
   }
end
-- for work
local edit_platform = function()
   require("telescope.builtin").find_files {
      shorten_path = false,
      cwd = "~/code/platform",
      prompt = "~ Identitii platform ~",
      hidden = true,

      layout_strategy = "horizontal",
      layout_config = {
         preview_width = 0.55,
      },
   }
end
vim.keymap.set("n", "<leader>fq", function()
   tele.quickfix {}
end)
vim.keymap.set("n", "<leader>fc", function()
   tele.command_history {}
end)
vim.keymap.set("n", "<leader>fr", function()
   tele.lsp_references {}
end)
vim.keymap.set("n", "<leader>fn", edit_neovim)
vim.keymap.set("n", "<leader>fi", edit_platform)
