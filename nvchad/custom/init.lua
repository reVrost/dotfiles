-- local ls = require "luasnip"
local opt, g, fn = vim.opt, vim.g, vim.fn
-- g.luasnippets_path = "custom.snippets"
-- require "custom.snippets.init"

-- vim opts
opt.belloff = "all"
opt.relativenumber = true
opt.encoding = "utf-8"

-- WSL clipboard
if vim.fn.has "wsl" == 1 then
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

vim.api.nvim_create_user_command("DiffviewToggle", function(e)
   local view = require("diffview.lib").get_current_view()

   if view then
      vim.cmd "DiffviewClose"
   else
      vim.cmd("DiffviewOpen " .. e.args)
   end
end, { nargs = "*" })

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

function _G.smart_tab()
   return require("luasnip").expand_or_jumpable() and t "<Plug>luasnip-expand-or-jump" or t "<Tab>"
end
