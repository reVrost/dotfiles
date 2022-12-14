return {
   ["neovim/nvim-lspconfig"] = {
      config = function()
         require "plugins.configs.lspconfig"
         require "custom.plugins.lspconfig"
      end,
   },
   ["kyazdani42/nvim-tree.lua"] = {
      -- disable lazy load
      after = "nvim-web-devicons",
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },
   ["karb94/neoscroll.nvim"] = {},
   ["ggandor/leap.nvim"] = {
      config = function()
         require("leap").add_default_mappings()
      end,
   },
   ["tpope/vim-surround"] = {},
   ["simrat39/symbols-outline.nvim"] = {
      opt = true,
      cmd = { "SymbolsOutline" },
   },
   ["fatih/vim-go"] = {},
   ["mg979/vim-visual-multi"] = {},
   ["luukvbaal/stabilize.nvim"] = {
      config = function()
         require("stabilize").setup()
      end,
   },
   ["sindrets/diffview.nvim"] = {
      requires = "nvim-lua/plenary.nvim",
      after = "plenary.nvim",
   },
   ["ThePrimeagen/harpoon"] = {
      requires = "nvim-lua/plenary.nvim",
   },
   -- ["reVrost/played.nvim"] = {},
   ["max397574/better-escape.nvim"] = {
      config = function()
         require("better_escape").setup {
            mapping = { "jk", "jj" },
         }
      end,
   },
   ["folke/trouble.nvim"] = {
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
   },
   ["folke/zen-mode.nvim"] = {
      config = function()
         require("zen-mode").setup {}
      end,
   },
   -- Override plugin config if it has a module called
   -- If you wish to call a module, which is 'cmp' in this case
   ["hrsh7th/nvim-cmp"] = {
      override_options = function()
         local cmp = require "cmp"

         return {
            mapping = {
               ["<C-p>"] = cmp.mapping.select_prev_item(),
               ["<C-n>"] = cmp.mapping.select_next_item(),
               ["<C-d>"] = cmp.mapping.scroll_docs(-4),
               ["<C-f>"] = cmp.mapping.scroll_docs(4),
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<C-e>"] = cmp.mapping.close(),
               ["<CR>"] = cmp.mapping.confirm {
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
               },
               ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                     -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
                     require("luasnip").jump(1)
                  else
                     fallback()
                  end
               end, {
                  "i",
                  "s",
               }),
               ["<S-Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                     -- vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
                     require("luasnip").jump(-1)
                  else
                     fallback()
                  end
               end, {
                  "i",
                  "s",
               }),
            },
         }
      end,
   },
   ["nvim-treesitter/nvim-treesitter"] = {},
   ["nvim-treesitter/nvim-treesitter-context"] = {},
}
