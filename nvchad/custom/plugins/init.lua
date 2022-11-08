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
   ["nvim-treesitter/nvim-treesitter"] = {},
   ["nvim-treesitter/nvim-treesitter-context"] = {},
}
