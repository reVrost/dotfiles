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
      "tpope/vim-surround",
   },
   {
      "github/copilot.vim",
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
   {
      "rmagatti/auto-session",
      config = function()
         require("auto-session").setup {
            log_level = "info",
            auto_session_suppress_dirs = { "~/", "~/Projects" },
            auto_save_enabled = true,
            auto_restore_enabled = true,
            pre_save_cmds = { "lua require'nvim-tree'.setup()", "tabdo NvimTreeClose" },
            --post_restore_cmds = { "lua require'nvim-tree'.setup()", "tabdo NvimTreeOpen" },
         }
      end,
   },
   {
      "ThePrimeagen/harpoon",
   },
}
