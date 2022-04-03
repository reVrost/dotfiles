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
      "matze/vim-move",
   },
   {
      "simrat39/symbols-outline.nvim",
   },
   {
      "fatih/vim-go",
   },
}
