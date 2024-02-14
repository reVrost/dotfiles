local plugins = {
   {
      "neovim/nvim-lspconfig",
      config = function()
         require "plugins.configs.lspconfig"
         require "custom.lspconfig"
      end,
      dependencies = {
         {
            "jose-elias-alvarez/null-ls.nvim",
            after = "nvim-lspconfig",
            config = function()
               require("custom.null-ls").setup()
            end,
         },
      },
   },
   {
      "github/copilot.vim",
      lazy = false,
      config = function()
         -- Mapping tab is already used by NvChad
         vim.g.copilot_no_tab_map = true
         vim.g.copilot_assume_mapped = true
         vim.g.copilot_tab_fallback = ""
         -- The mapping is set to other key, see custom/lua/mappings
         -- or run <leader>ch to see copilot mapping section
      end,
   },
   {
      "karb94/neoscroll.nvim",
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "tpope/vim-surround",
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "fatih/vim-go",
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "mg979/vim-visual-multi",
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      lazy = false, -- Assuming you want to load it with 'plenary.nvim'
   },

   {
      "echasnovski/mini.files",
      version = false,
      lazy = false,
      config = function()
         require("mini.files").setup {}
      end,
   },
   -- {
   --    "nvimdev/lspsaga.nvim",
   --    config = function()
   --       require("lspsaga").setup {}
   --    end,
   -- },
   {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("better_escape").setup {
            mapping = { "jk", "jj" },
         }
      end,
   },
   {
      "folke/zen-mode.nvim",
      config = function()
         require("zen-mode").setup {}
      end,
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "folke/which-key.nvim",
      enabled = false,
   },
   {
      "hrsh7th/nvim-cmp",
      --       sources = {
      --          { name = "nvim_lsp" },
      --          { name = "luasnip" },
      --          { name = "buffer" },
      --          { name = "nvim_lua" },
      --          { name = "path" },
      --          { name = "cmp_tabnine" },
      --       },
      --       experimental = {
      --          ghost_text = true,
      --       },
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
   {
      "nvim-treesitter/nvim-treesitter",
      opts = {
         ensure_installed = {
            "vim",
            "lua",
            "html",
            "css",
            "javascript",
            "typescript",
            "go",
            "python",
            "tsx",
            "c",
            "markdown",
            "markdown_inline",
         },
         incremental_selection = {
            enable = true,
            keymaps = {
               init_selection = "<C-a>",
               node_incremental = "<C-a>",
               scope_incremental = "grc",
               node_decremental = "<C-x>",
            },
         },
         indent = {
            enable = true,
            -- disable = {
            --   "python"
            -- },
         },
      },
   },
   {
      "williamboman/mason.nvim",
      opts = {
         ensure_installed = {
            -- lua stuff
            "lua-language-server",
            "stylua",

            -- web dev stuff
            "css-lsp",
            "html-lsp",
            "typescript-language-server",
            "deno",
            "prettier",

            -- c/cpp stuff
            "clangd",
            "clang-format",
         },
      },
   },
   {
      "nvim-tree/nvim-tree.lua",
      lazy = true,
      opts = {
         git = {
            enable = true,
         },

         --       view = {
         --          adaptive_size = true,
         --       },
         renderer = {
            highlight_git = true,
            icons = {
               show = {
                  git = true,
               },
            },
         },
      },
   },

   {
      "nvim-treesitter/nvim-treesitter-context",
      lazy = false, -- Assuming you want to load it at startup
   },
   {
      "ggandor/leap.nvim",
      lazy = false,
   },
   {
      "lewis6991/gitsigns.nvim",
      opts = {
         current_line_blame = true,
         current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 250,
            ignore_whitespace = false,
         },
         current_line_blame_formatter = "\t<author>, <author_time:%Y-%m-%d> - <summary>",
      },
   },
   -- {
   --   "sindrets/diffview.nvim",
   --   after = "plenary.nvim",
   --   requires = "nvim-lua/plenary.nvim",
   --   lazy = false, -- Assuming you want to load it after 'plenary.nvim'
   -- },
   -- ["reVrost/played.nvim"] is commented out in the original list
   {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
      lazy = false, -- Assuming you want to load it with 'nvim-web-devicons'
   },
}
return plugins
