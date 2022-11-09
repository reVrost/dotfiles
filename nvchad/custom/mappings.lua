local M = {}

M.general = {
   n = {

      ["c"] = { '"_c' }, -- don't yank on change
      ["q"] = { "<nop>" },
      ["<leader>s"] = { ":HopWord <CR>" },
      ["<leader>q"] = { ":SymbolsOutline <CR>" },
      ["<leader>rt"] = { ":GoTestFunc <CR>" },
      ["<leader>dd"] = { ":DiffviewToggle <CR>" },
      ["<leader>zz"] = { ":ZenMode <CR>" },
      ["<leader>xx"] = { ":TroubleToggle document_diagnostics<CR>" },
      ["<leader>ra"] = { "<cmd>lua vim.lsp.buf.rename()<CR>" },
      ["ge"] = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" },

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
         { silent = true },
      },
      ["<leader>1"] = {
         function()
            require("harpoon.ui").nav_file(1)
         end,
         { silent = true },
      },
      ["<leader>2"] = {
         function()
            require("harpoon.ui").nav_file(2)
         end,
         { silent = true },
      },
      ["<leader>3"] = {
         function()
            require("harpoon.ui").nav_file(3)
         end,
         { silent = true },
      },
      ["<leader>4"] = {
         function()
            require("harpoon.ui").nav_file(4)
         end,
         { silent = true },
      },
      ["<leader>5"] = {
         function()
            require("harpoon.ui").nav_file(5)
         end,
         { silent = true },
      },

      -- telescopes keybind
      ["<leader>fq"] = {
         function()
            require("telescope.builtin").quickfix()
         end,
         { silent = true },
      },
      ["<leader>fr"] = {
         function()
            require("telescope.builtin").lsp_references()
         end,
         { silent = true },
      },
      ["<leader>fc"] = {
         function()
            require("telescope.builtin").command_history()
         end,
         { silent = true },
      },
      ["<leader>fi"] = {
         function()
            require("telescope.builtin").lsp_implementations()
         end,
         { silent = true },
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
   },

   i = {
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
