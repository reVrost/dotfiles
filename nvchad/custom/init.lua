-- local ls = require "luasnip"
local opt, g, fn = vim.opt, vim.g, vim.fn
-- g.luasnippets_path = "custom.snippets"
-- require "custom.snippets.init"

-- vim opts
opt.belloff = "all"
opt.relativenumber = true
opt.encoding = "utf-8"

-- Global funcs, utilities
local t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

_G.snip_complete = function()
   if fn.pumvisible() == 1 then
      return t "<C-n>"
   elseif require("luasnip").expand_or_jumpable() then
      return t "<Plug>luasnip-expand-or-jump"
   end
   return ""
end

_G.r_snip_complete = function()
   if fn.pumvisible() == 1 then
      return t "<C-p>"
   elseif require("luasnip").jumpable(-1) then
      return t "<Plug>luasnip-jump-prev"
   end
   return ""
end
