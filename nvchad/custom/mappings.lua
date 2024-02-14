local M = {}

-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
local function t(str)
   -- Adjust boolean arguments as needed
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

M.copilot = {
   i = {
      ["<C-;>"] = {
         function()
            vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
         end,
         "Copilot Accept",
         { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
      },
   },
}
M.general = {
   n = {

      ["c"] = { '"_c' }, -- don't yank on change
      ["C"] = { '"_C' }, -- don't yank on change
      ["q"] = { "<nop>" },
      ["<leader>s"] = { ":HopWord <CR>" },
      -- run commands
      ["<leader>r"] = { ":lua run_command()<CR>" },
      ["<leader>rt"] = { ":GoTestFunc <CR>" },
      ["<leader>dd"] = { ":DiffviewToggle <CR>" },
      --
      ["<leader>e"] = { "<cmd>lua MiniFiles.open()<CR>" },
      ["<leader>zz"] = { ":ZenMode <CR>" },
      ["<leader>lr"] = { ":LspRestart <CR>" },
      ["<leader>li"] = { ":LspInfo <CR>" },
      ["<leader>ms"] = { ":Mason <CR>" },
      ["<leader>xx"] = { ":TroubleToggle lsp_document_diagnostics<CR>" },
      ["<leader>ra"] = { "<cmd>lua vim.lsp.buf.rename()<CR>" },
      ["<leader>ca"] = { "<cmd>vim.lsp.buf.code_action()<CR>" },
      ["<leader>qa"] = { ":qa!<CR>" },
      ["<leader>wa"] = { ":wa<CR>" },
      ["ge"] = { "<cmd>lua vim.diagnostic.open_float()<CR>" },
      ["gk"] = { "<cmd>lua vim.lsp.buf.hover()<CR>" },

      -- macros/snippets
      ["<leader>ee"] = { "oif err != nil {<CR>}<Esc>Oreturn err<Esc>" },

      -- reload snippets
      ["<leader>rs"] = { "<cmd>source ~/.config/nvim/lua/custom/snippets/init.lua<CR>" },

      -- harpoon keybinds
      ["<leader>a"] = {
         function()
            require("harpoon.mark").add_file()
         end,
      },
      ["<leader>hh"] = {
         function()
            require("harpoon.ui").toggle_quick_menu()
         end,
      },
      ["<leader>1"] = {
         function()
            require("harpoon.ui").nav_file(1)
         end,
      },
      ["<leader>2"] = {
         function()
            require("harpoon.ui").nav_file(2)
         end,
      },
      ["<leader>3"] = {
         function()
            require("harpoon.ui").nav_file(3)
         end,
      },
      ["<leader>4"] = {
         function()
            require("harpoon.ui").nav_file(4)
         end,
      },
      ["<leader>5"] = {
         function()
            require("harpoon.ui").nav_file(5)
         end,
      },

      -- telescopes keybind
      ["<leader>fq"] = {
         function()
            require("telescope.builtin").quickfix()
         end,
      },
      ["<leader>fr"] = {
         function()
            require("telescope.builtin").lsp_references()
         end,
      },
      ["<leader>fc"] = {
         function()
            require("telescope.builtin").command_history()
         end,
      },
      ["<leader>fi"] = {
         function()
            require("telescope.builtin").lsp_implementations()
         end,
      },
      -- ["<leader>fn"] = {
      --   function()
      --      require("telescope.builtin").find_files {
      --         shorten_path = false,
      --         cwd = "~/.config/nvim/lua/custom/",
      --         prompt = "~ dotfiles ~",
      --         hidden = true,
      --
      --         layout_strategy = "horizontal",
      --         layout_config = {
      --            preview_width = 0.55,
      --         },
      --      },
      --    end,
      -- },
      -- ["<leader>fi"] = {
      --   function()
      --      require("telescope.builtin").find_files {
      --         shorten_path = false,
      --         cwd = "~/code/platform",
      --         prompt = "~ Identitii platform ~",
      --         hidden = true,
      --
      --         layout_strategy = "horizontal",
      --         layout_config = {
      --            preview_width = 0.55,
      --         },
      --      },
      --    end
      -- },
   },
   v = {
      ["c"] = { '"_c' }, -- don't yank on change
      ["q"] = { "<nop>" },
      ["<leader>ca"] = { "<cmd>vim.lsp.buf.code_action()<CR>" },
   },

   i = {
      ["<Tab>"] = {
         "v:lua.smart_tab()",
         "Jump to next",
         opts = { expr = true },
      },

      -- -- snippets keybind
      ["<c-k>"] = { "v:lua.snip_complete()" },
      ["<c-j>"] = { "v:lua.r_snip_complete()" },
   },
   s = {
      -- -- snippets keybind
      ["<c-k>"] = { "v:lua.snip_complete()" },
      ["<c-j>"] = { "v:lua.r_snip_complete()" },
      ["<c-l>"] = { "<Plug>luansip-next-choice" },
   },
}

return M
