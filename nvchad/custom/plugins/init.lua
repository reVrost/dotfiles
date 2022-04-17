return {
   {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.null-ls").setup()
      end,
   },
   {
      "karb94/neoscroll.nvim",
   },
   {
      "phaazon/hop.nvim",
      config = function()
         require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
      end,
   },
   {
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
   },
   {
      "tpope/vim-surround",
   },
   {
      "simrat39/symbols-outline.nvim",
      opt = true,
      cmd = { "SymbolsOutline" },
   },
   {
      "fatih/vim-go",
   },
   {
      "mg979/vim-visual-multi",
   },
   {
      "luukvbaal/stabilize.nvim",
      config = function()
         require("stabilize").setup()
      end,
   },
}
