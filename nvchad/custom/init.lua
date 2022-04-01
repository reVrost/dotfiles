local map = require("core.utils").map

-- Mappings
map("n", "<leader>s", ":HopWord <CR>")
-- dont yank on change
map({ "n", "v" }, "c", '"_c')
