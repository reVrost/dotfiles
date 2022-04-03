local map = require("core.utils").map
-- Mappings

map("n", "<leader>s", ":HopWord <CR>")
map("n", "<leader>z", ":SymbolsOutline <CR>")
map("n", "<leader>w", ":w <CR>")
map("n", "<leader>q", ":qa <CR>")

-- I never use q (recording, and it always get in the way, so bind it out)
map({ "n", "v" }, "q", "<nop>")

-- dont yank on change
map({ "n", "v" }, "c", '"_c')
