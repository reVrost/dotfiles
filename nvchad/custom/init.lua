-- local ls = require "luasnip"
local opt, g, fn = vim.opt, vim.g, vim.fn
-- g.luasnippets_path = "custom.snippets"
-- require "custom.snippets.init"

-- vim opts
opt.belloff = "all"
opt.relativenumber = true
opt.encoding = "utf-8"
opt.splitkeep = "screen"

-- vim snippets
g.vscode_snippets_path = fn.stdpath "config" .. "/lua/custom/snippets"
g.lua_snippets_path = fn.stdpath "config" .. "/lua/custom/snippets"

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

_G.run_command = function()
   local filetype = vim.bo.filetype
   if filetype == "c" then
      vim.cmd "!sh run.sh"
   end
   if filetype == "go" then
      run_make_dev()
   end
end

-- specific to whatever you're working on atm
_G.run_make_dev = function()
   -- Find the directory containing the Makefile
   local makefile_path = vim.fn.findfile("Makefile", ".")
   print "Rebuilding..."

   -- Check if Makefile is found
   if makefile_path ~= "" then
      -- Change to the directory containing the Makefile
      local makefile_dir = vim.fn.fnamemodify(makefile_path, ":h")
      vim.cmd("cd " .. makefile_dir)

      -- Kill previous process if running
      vim.fn.system "pkill -f marketpal_server"

      -- Run make dev
      vim.fn.jobstart("make dev", { detach = true })
      print "Dev is running."
   else
      print "Makefile not found."
   end
end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
   group = highlight_group,
   callback = function()
      vim.highlight.on_yank()
   end,
})

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

vim.keymap.set({ "n", "x", "o" }, "s", function()
   local current_window = vim.fn.win_getid()
   require("leap").leap { target_windows = { current_window } }
end)
