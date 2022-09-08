return {
   ["L3MON4D3/LuaSnip"] = {
      branch = "ls_snippets_preserve",
   },
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
   ["hrsh7th/nvim-cmp"] = {
      after = "nvim-web-devicons",
   },
   ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   },
   ["karb94/neoscroll.nvim"] = {},
   ["phaazon/hop.nvim"] = {
      config = function()
         require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
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
   ["reVrost/played.nvim"] = {},
   ["max397574/better-escape.nvim"] = {
      config = function()
         require("better_escape").setup {
            mapping = { "jk", "jj" },
         }
      end,
   },
   ["nvim-treesitter/nvim-treesitter"] = {},
   ["nvim-treesitter/nvim-treesitter-context"] = {},
}
