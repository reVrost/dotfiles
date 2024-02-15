local plugins = {
   {
      "echasnovski/mini.files",
      version = false,
      lazy = false,
      config = function()
         require("mini.files").setup {
            mappings = {
               go_in_plus = "l",
               go_out_plus = "h",
            },
         }
      end,
   },
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
      "utilyre/barbecue.nvim",
      name = "barbecue",
      lazy = false,
      version = "*",
      dependencies = {
         "SmiteshP/nvim-navic",
         "nvim-tree/nvim-web-devicons", -- optional dependency
      },
      opts = {
         -- configurations go here
      },
   },
   -- switch to dropbar later when upgrade to nvim 0.10
   -- {
   --    "Bekaboo/dropbar.nvim",
   --    -- optional, but required for fuzzy finder support
   --    config = function()
   --       require("dropbar").setup {
   --          general = {
   --             enable = true,
   --          },
   --       }
   --    end,
   --    dependencies = {
   --       "nvim-telescope/telescope-fzf-native.nvim",
   --    },
   --    lazy = false,
   -- },
   {
      "karb94/neoscroll.nvim",
      lazy = false,
   },
   {
      "tpope/vim-surround",
      lazy = false,
   },
   {
      "fatih/vim-go",
      lazy = false,
   },
   {
      "mg979/vim-visual-multi",
      lazy = false,
   },
   {
      "ThePrimeagen/harpoon",
      requires = "nvim-lua/plenary.nvim",
      lazy = false,
   },
   -- {
   --    "rmagatti/auto-session",
   --    lazy = false,
   --    config = function()
   --       require("auto-session").setup {
   --          log_level = "error",
   --          auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
   --       }
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
      lazy = false,
   },
   -- {
   --    "nvimdev/lspsaga.nvim",
   --    config = function()
   --       require("lspsaga").setup {}
   --    end,
   -- },
   {
      "folke/which-key.nvim",
      enabled = false,
   },
   {
      "hrsh7th/nvim-cmp",
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
               scope_incremental = "grc",
               node_incremental = "<C-a>",
               node_decremental = "<bs>",
            },
         },
         indent = {
            enable = true,
         },
         context_commentstring = {
            enable = true,
            enable_autocmd = false,
            config = {
               tsx = "{/* %s */}",
            },
         },
         textobjects = {
            select = {
               enable = true,
               lookahead = true,
               keymaps = {
                  ["a="] = "@assignment.outer",
                  ["i="] = "@assignment.inner",
                  ["at"] = "@comment.outer",
                  ["it"] = "@comment.inner",
                  ["aa"] = "@parameter.outer",
                  ["ia"] = "@parameter.inner",
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                  ["ab"] = "@block.outer",
                  ["ib"] = "@block.inner",
               },
            },
            swap = {
               enable = true,
               swap_next = {
                  ["<Leader>a"] = "@parameter.inner",
               },
               swap_previous = {
                  ["<Leader>A"] = "@parameter.inner",
               },
            },
            lsp_interop = {
               enable = true,
            },
         },
      },
   },
   -- {
   --    "nvim-treesitter/nvim-treesitter-context",
   --    lazy = false,
   -- },
   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      lazy = false,
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
      enable = false,
      lazy = true,
      opts = {
         git = {
            enable = true,
         },
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
   --    "sindrets/diffview.nvim",
   --    after = "plenary.nvim",
   --    requires = "nvim-lua/plenary.nvim",
   --    lazy = true,
   -- },
   -- ["reVrost/played.nvim"] is commented out in the original list
   {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
      lazy = true,
   },
   {
      "iamcco/markdown-preview.nvim",
      cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
      ft = { "markdown" },
      build = function()
         vim.fn["mkdp#util#install"]()
      end,
   },
}
return plugins
