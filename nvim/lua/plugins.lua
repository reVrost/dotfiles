local plugins = {
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    opts = {
      opts = {
        buflisted = false,
        number = true,
        relativenumber = true,
        signcolumn = "auto",
        winfixheight = true,
        wrap = false,
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gs",             -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.ai",
    version = false,
    config = function()
      local ai = require "mini.ai"
      require("mini.ai").setup {
        n_lines = 500,
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" }, -- function
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },          -- tags
        },
      }
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },
  {
    "echasnovski/mini.files",
    version = false,
    config = function()
      require("mini.files").setup {
        mappings = {
          go_in_plus = "l",
          go_out_plus = "h",
        },
        options = {
          use_as_default_explorer = false,
        },
        windows = {
          preview = false,
        },
      }
    end,
  },
  {
    "echasnovski/mini.indentscope",
    version = false,
    config = function()
      local id = require "mini.indentscope"
      id.setup {
        draw = {
          delay = 10,
          animation = id.gen_animation.cubic { duration = 100, unit = "total" },
        },
        symbol = "│",
      }
    end,
  },
  {
    "andymass/vim-matchup",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "itchyny/vim-cursorword",
  },
  {
    "romainl/vim-cool",
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      require("dashboard").setup {
        -- config
        -- {
        theme = "hyper",
        config = {
          header = {
            "=================     ===============     ===============   ========  ========",
            "\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //",
            "||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||",
            "|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||",
            "||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||",
            "|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||",
            "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
            "|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||",
            "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
            "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
            "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
            "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
            "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
            "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
            "||   .=='    _-'          '-__\\._-'         '-_./__-'         `' |. /|  |   ||",
            "||.=='    _-'                                                     `' |  /==.||",
            "==    _-'                        N E O V I M                         \\/   `==",
            "\\   _-'                                                                `-_   /",
            " `''                                                                      ``'",
          },
          -- week_header = {
          --    enable = true,
          -- },
          shortcut = {
            { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
            {
              icon = " ",
              icon_hl = "@variable",
              desc = "Files",
              group = "Label",
              action = "Telescope find_files",
              key = "f",
            },
            {
              desc = " Apps",
              group = "DiagnosticHint",
              action = "Telescope app",
              key = "a",
            },
            {
              desc = " dotfiles",
              group = "Number",
              action = "Telescope dotfiles",
              key = "d",
            },
          },
        },
      }
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    opts = {
      extensions_list = {
        "themes",
        "terms",
        "fzf",
        "live_grep_args",
      },
      extensions = {
        live_grep_args = {
          auto_quoting = true,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<C-;>",
        clear_suggestion = "<C-]>",
        accept_word = "<C->",
      },
    },
  },
  -- {
  --   "github/copilot.vim",
  --   config = function()
  --     -- Mapping tab is already used by NvChad
  --     vim.g.copilot_no_tab_map = true
  --     vim.g.copilot_assume_mapped = true
  --     vim.g.copilot_tab_fallback = ""
  --     -- The mapping is set to other key, see custom/lua/mappings
  --     -- or run <leader>ch to see copilot mapping section
  --   end,
  -- },
  -- {
  --   "tpope/vim-surround",
  --   lazy = false,
  -- },
  {
    "fatih/vim-go",
    lazy = false,
  },
  {
    "folke/which-key.nvim",
    enabled = false,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "ggandor/leap.nvim",
  },
  {
    "ggandor/flit.nvim",
    opts = {},
  },
  -- {
  --   "sindrets/diffview.nvim",
  --   lazy = true,
  -- },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "scss",
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
        enable_autocmd = false,
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
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<Leader>a"] = "@parameter.inner",
        --   },
        --   swap_previous = {
        --     ["<Leader>A"] = "@parameter.inner",
        --   },
        -- },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]a"] = { query = "@parameter.inner", desc = "Next function call start" },
            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          },
          goto_next_end = {
            ["]A"] = { query = "@parameter.inner", desc = "Next function call start" },
            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          },
          goto_previous_start = {
            ["[a"] = { query = "@parameter.inner", desc = "Next function call start" },
            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[A"] = { query = "@parameter.inner", desc = "Next function call start" },
            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
          },
        },
        lsp_interop = {
          enable = true,
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",

    config = function()
      require("mason").setup({
        ensure_installed = {
          -- lua stuff
          "lua-language-server",
          "stylua",
          "luacheck",
          "jdtls@v1.12.0",

          -- web dev stuff
          "css-lsp",
          "html-lsp",
          "typescript-language-server",
          "deno",
          "prettier",
          "prettierd",
          "shfmt",
          "terraform_fmt",

          -- c/cpp stuff
          "clangd",
          "clang-format",
        },
      })
    end,
    -- opts = {
    -- },
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
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
  --   "iamcco/markdokn-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function()
  --     vim.fn["mkdp#util#install"]()
  --   end,
  -- },
  -- For fun
  {
    "eandrju/cellular-automaton.nvim",
  },
  -- {
  --   "sphamba/smear-cursor.nvim",
  --
  --   opts = {
  --     smear_between_neighbor_lines = false,
  --     cursor_color = "#d3cdc3",
  --     transparent_bg_fallback_color = "#303030",
  --   },
  -- },
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local actions = require("fzf-lua").actions
      require("fzf-lua").setup {
        grep = {
          rg_glob = true,
          glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        },
        defaults = {
          actions = {
            ["ctrl-q"] = { fn = actions.file_sel_to_qf, prefix = "select-all+" },
          },
        },
      }
    end,
  },
  {
    "Bekaboo/dropbar.nvim",
    dependencies = {
      -- optional, but required for fuzzy finder support
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    opts = {
      bar = {
        enable = function(buf, win, _)
          -- Fetch buffer name
          local bufname = vim.api.nvim_buf_get_name(buf)
          -- Fetch all open windows and check if any Diffview buffer is active
          local diffview_active = false
          for _, w in ipairs(vim.api.nvim_list_wins()) do
            local b = vim.api.nvim_win_get_buf(w)
            local name = vim.api.nvim_buf_get_name(b)
            if name:match "^diffview://" then
              diffview_active = true
              break
            end
          end

          -- Disable dropbar for all Diffview windows
          return not diffview_active
              and vim.api.nvim_buf_is_valid(buf)
              and vim.api.nvim_win_is_valid(win)
              and vim.wo[win].winbar == ""
              and vim.fn.win_gettype(win) == ""
              and ((pcall(vim.treesitter.get_parser, buf)) and true or false)
        end,
      },
    },
  },
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false, -- set this if you want to always pull the latest change
  --   opts = {
  --     provider = "openrouter",
  --     providers = {
  --       openrouter = {
  --         __inherited_from = "openai",
  --         endpoint = "https://openrouter.ai/api/v1",
  --         model = "google/gemini-2.5-flash",
  --         api_key_name = "OPENROUTER_API_KEY",
  --         extra_request_body = {
  --           temperature = 0.6,
  --           max_tokens = 8000,
  --         },
  --       },
  --     },
  --     behaviour = {
  --       support_paste_from_clipboard = true,
  --       auto_apply_diff_after_generation = true,
  --     },
  --     mappings = {
  --       toggle = {
  --         default = "<leader>aa",
  --       },
  --       submit = { normal = "<CR>", insert = "<CR>" },
  --       suggestion = {
  --         accept = "<M-j>",
  --         next = "<M-l>",
  --         prev = "<M-h>",
  --         dismiss = "<M-k>",
  --       },
  --       jump = {
  --         next = "]]",
  --         prev = "[[",
  --       },
  --     },
  --     windows = {
  --       -- position = "smart",
  --       sidebar_header = {
  --         align = "left", -- left, center, right for title
  --         rounded = false,
  --         enabled = false,
  --       },
  --       input = { prefix = "➜ " },
  --       ask = { start_insert = true },
  --       edit = { start_insert = true },
  --     },
  --     file_selector = {
  --       start_insert = true,
  --       provider = "fzf",
  --     },
  --   },
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   build = "make",
  --   -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  --   dependencies = {
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --           -- required for Windows users
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
  {
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  {
    "tronikelis/conflict-marker.nvim",
    config = function()
      require("conflict-marker").setup {
        highlights = true,

        on_attach = function(conflict)
          local map = function(key, fn)
            vim.keymap.set("n", key, fn, { buffer = conflict.bufnr })
          end
          local MID = "^=======$"

          map("[x", function()
            vim.cmd("?" .. MID)
          end)

          map("]x", function()
            vim.cmd("/" .. MID)
          end)

          map("co", function()
            conflict:choose_ours()
          end)
          map("ct", function()
            conflict:choose_theirs()
          end)
          map("cb", function()
            conflict:choose_both()
          end)
          map("cn", function()
            conflict:choose_none()
          end)
        end,
      }
    end,
  },
  -- {
  --   "nvim-java/nvim-java",
  --   config = function()
  --   end,
  -- },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      -- your options here
    }
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "Notes",
  --         path = "~/code/reVrost/obsidianvault/",
  --       },
  --     },
  --     note_id_func = function(title)
  --       local suffix = ""
  --       if title ~= nil then
  --         suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
  --       else
  --         suffix = "note" -- Default to "note" instead of random letters
  --       end
  --       return suffix .. "-" .. tostring(os.time())
  --     end,
  --
  --     -- see below for full list of options 👇
  --   },
  -- },
}
return plugins
