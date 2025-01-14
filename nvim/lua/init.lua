-- local ls = require "luasnip"
local opt, g, fn = vim.opt, vim.g, vim.fn
local augroup = vim.api.nvim_create_augroup
local cmd = vim.api.nvim_create_user_command

-- vim opts
opt.belloff = "all"
opt.relativenumber = true
opt.encoding = "utf-8"
opt.splitkeep = "screen"
opt.fillchars:append { diff = "╱" }

-- vim snippets
g.vscode_snippets_path = fn.stdpath "config" .. "/lua/snippets"
g.lua_snippets_path = fn.stdpath "config" .. "/lua/snippets"
g.go_term_mode = "vsplit"
g.go_term_enabled = 1

-- if using neovide
g.neovide_scale_factor = 0.8

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- auto trim trailing whitespace
local trim_whitespace_group = augroup("trim_whitespace", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = trim_whitespace_group,
  callback = function()
    -- basically the same as mini.trailspace
    local curpos = vim.api.nvim_win_get_cursor(0)
    ---Search and replace trailing whitespace
    vim.cmd [[keeppatterns %s/\s\+$//e]]
    vim.api.nvim_win_set_cursor(0, curpos)
  end,
})
-- -- General Diff Highlights
-- vim.api.nvim_set_hl(0, "DiffAdd", { fg = "none", bg = "#103235" })
-- vim.api.nvim_set_hl(0, "DiffChange", { fg = "#ffffff", bg = "#ffffff" })
-- vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#394b70" })
-- vim.api.nvim_set_hl(0, "DiffDelete", { fg = "none", bg = "#3F2D3D" })
-- vim.api.nvim_set_hl(0, "DiffviewDiffAddAsDelete", { fg = "#ffffff", bg = "#3f2d3d" })
vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { fg = "#3B4252", bg = "none" })

-- Conflict markers
vim.api.nvim_set_hl(0, "ConflictOurs", { fg = "none", bg = "#405060" })
vim.api.nvim_set_hl(0, "ConflictTheirs", { fg = "none", bg = "#415050" })

--
-- -- Left Panel Highlights
-- vim.api.nvim_set_hl(0, "DiffAddAsDelete", { fg = "none", bg = "#3F2D3D" })
-- vim.api.nvim_set_hl(0, "DiffDeleteText", { fg = "none", bg = "#4B1818" })
--
-- -- Right Panel Highlights
-- vim.api.nvim_set_hl(0, "DiffAddText", { fg = "#ffffff", bg = "#1C5458" })
-- vim.api.nvim_set_hl(0, "LeapMatch", {
--   ---For light themes, set to 'black' or similar.
--   fg = vim.go.background == "dark" and "white" or "black",
--   bold = true,
--   nocombine = true,
-- })

-- temp
vim.lsp.set_log_level "debug"

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

local float_state = {
  buf = -1,
  win = -1,
}

local function is_terminal_running(buf)
  local job_id = vim.b[buf].terminal_job_id
  if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
    return true
  end
  return false
end

_G.open_term = function(command, title, buf)
  if not vim.api.nvim_buf_is_valid(buf) or not is_terminal_running(buf) then
    if not buf == -1 then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
    buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, title) -- Set a name for the buffer
  end
  -- Create a terminal buffer (modifiable and persistent)
  local win_config = {
    style = "minimal",
    relative = "editor",
    width = math.ceil(vim.o.columns * 0.8),
    height = math.ceil(vim.o.lines * 0.8),
    row = math.ceil((vim.o.lines - math.ceil(vim.o.lines * 0.8)) / 2),
    col = math.ceil((vim.o.columns - math.ceil(vim.o.columns * 0.8)) / 2),
    border = "rounded",
  }
  title = title or "[Terminal]"

  local win = vim.api.nvim_open_win(buf, true, win_config)
  vim.api.nvim_set_current_win(win)

  -- Launch a terminal if its the first time
  if not is_terminal_running(buf) then
    vim.fn.termopen(vim.o.shell, {
      on_exit = function(_, _, _)
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end,
    })
    -- Automatically run the command once the terminal is ready
    if command and command ~= "" then
      vim.cmd "startinsert"
      vim.defer_fn(function()
        vim.api.nvim_chan_send(vim.b.terminal_job_id, command .. "\n")
      end, 50)
    else
      vim.cmd "startinsert"
    end
  end

  return { buf = buf, win = win }
end

cmd("GitTerminal", function()
  if not vim.api.nvim_win_is_valid(float_state.win) then
    float_state = _G.open_term("git status", "[Git Status]", float_state.buf)
  else
    vim.api.nvim_win_hide(float_state.win)
  end
end, { nargs = "*" })

cmd("GitDelta", function()
  _G.open_term("git diff", "[Git Delta]")
end, { nargs = "*" })

cmd("RunGoTest", function()
  local ts_locals = require "nvim-treesitter.locals"
  local ts_utils = require "nvim-treesitter.ts_utils"
  local cursor_node = ts_utils.get_node_at_cursor()
  local scope = ts_locals.get_scope_tree(cursor_node, 0)
  local get_node_text = vim.treesitter.get_node_text
  local function_node, package_node
  local function_node_types = {
    function_declaration = true,
  }

  -- Find the function and package nodes
  for _, v in ipairs(scope) do
    if function_node_types[v:type()] then
      function_node = v
    end
    if v:type() == "source_file" then
      package_node = v
    end
  end

  if not function_node then
    print "Not in a function"
    return
  end

  -- Extract the function name and package name
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
    print "go.mod not found in the directory tree"
    return
  end

  local go_mod_directory = vim.fn.fnamemodify(go_mod_path, ":h")
  local cmd = "go test -v -count=1 ./.../" .. package .. " -run " .. function_name
  print("Running command in directory:", go_mod_directory)

  -- Use the global `open_terminal_window` function to run the command
  _G.open_term(cmd, "[Go Test Terminal]")
end, { nargs = "*" })

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
