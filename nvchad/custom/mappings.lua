local M = {}

M.copilot = {
   i = {
      ["<C-;>"] = {
         function()
            vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
         end,
         "Copilot Accept",
         { replace_keycodes = true, nowait = true, silent = true, expr = true, noremap = true },
      },
   },
}
M.disabled = {
   n = {
      ["gi"] = "",
   },
}
M.general = {
   n = {
      -- Alternative way to save and exit in Normal mode.
      -- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
      ["<C-s>"] = { "<cmd>w<CR><cmd>redraw<CR>" },

      -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      ["n"] = { "'Nn'[v:searchforward]", opts = { expr = true } },
      ["N"] = { "'nN'[v:searchforward]", opts = { expr = true } },

      ["c"] = { '"_c' }, -- don't yank on change
      ["C"] = { '"_C' }, -- don't yank on change
      ["q"] = { "<nop>" },

      -- QoL
      ["<leader>s"] = { ":%s/" },
      ["<leader>qa"] = { ":qa!<CR>" },
      ["<leader>wa"] = { ":wa<CR>" },

      -- run commands
      ["<leader>r"] = { ":lua run_command()<CR>" },

      -- plugins
      ["<leader>rt"] = { ":GoTestFunc <CR>" },
      ["<leader>gd"] = { ":DiffviewToggle <CR>" },
      ["<leader>md"] = { ":MarkdownPreview <CR>" },
      ["<leader>zz"] = { ":ZenMode <CR>" },
      ["<leader>lr"] = { ":LspRestart <CR>" },
      ["<leader>li"] = { ":LspInfo <CR>" },
      ["<leader>ms"] = { ":Mason <CR>" },
      ["<leader>e"] = { "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>" },

      -- Lsp Keymaps
      ["<leader>ra"] = { "<cmd>lua vim.lsp.buf.rename()<CR>" },
      ["<leader>ca"] = { "<cmd>vim.lsp.buf.code_action()<CR>" },
      ["gk"] = { "<cmd>lua vim.lsp.buf.hover()<CR>" },

      -- Diagonostics
      ["ge"] = { "<cmd>lua vim.diagnostic.open_float()<CR>" },
      ["[d"] = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>" },
      ["]d"] = { "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>" },

      -- snippets
      ["<leader>ee"] = { "oif err != nil {<CR>}<Esc>Oreturn err<Esc>" },

      -- reload snippets
      ["<leader>rs"] = { "<cmd>source ~/.config/nvim/lua/custom/snippets/init.lua<CR>" },

      -- harpoon keybinds
      ["<leader>`"] = {
         function()
            require("harpoon.mark").add_file()
         end,
      },
      ["<leader>hh"] = {
         function()
            require("harpoon.ui").toggle_quick_menu()
         end,
      },
      ["<leader>1"] = {
         function()
            require("harpoon.ui").nav_file(1)
         end,
      },
      ["<leader>2"] = {
         function()
            require("harpoon.ui").nav_file(2)
         end,
      },
      ["<leader>3"] = {
         function()
            require("harpoon.ui").nav_file(3)
         end,
      },
      ["<leader>4"] = {
         function()
            require("harpoon.ui").nav_file(4)
         end,
      },
      ["<leader>5"] = {
         function()
            require("harpoon.ui").nav_file(5)
         end,
      },

      -- telescopes keybind
      ["<leader>fq"] = {
         function()
            require("telescope.builtin").quickfix()
         end,
      },
      ["<leader>fr"] = {
         function()
            require("telescope.builtin").lsp_references()
         end,
      },
      ["<leader>fc"] = {
         function()
            require("telescope.builtin").command_history()
         end,
      },
      ["<leader>fi"] = {
         function()
            require("telescope.builtin").lsp_implementations()
         end,
      },
      ["<leader>fl"] = {
         function()
            require("telescope.builtin").resume()
         end,
      },
      ["<leader>fv"] = {
         function()
            require("telescope.builtin").find_files {
               shorten_path = false,
               cwd = "~/.config/nvim/lua/",
               prompt = "~ dotfiles ~",
               hidden = true,

               layout_strategy = "horizontal",
               layout_config = {
                  preview_width = 0.55,
               },
            }
         end,
      },
      ["<leader>fw"] = {
         function()
            local lga_actions = require "telescope-live-grep-args.actions"
            require("telescope").extensions.live_grep_args.live_grep_args {
               mappings = {
                  i = {
                     ["<C-k>"] = lga_actions.quote_prompt(),
                     ["<C-g>"] = lga_actions.quote_prompt { postfix = " --iglob " },
                  },
               },
               hidden = true,
               layout_strategy = "horizontal",
               layout_config = {
                  preview_width = 0.55,
               },
            }
         end,
      },
      -- telescope search in work directory
      ["<leader>fx"] = {
         function()
            local lga_actions = require "telescope-live-grep-args.actions"
            require("telescope").extensions.live_grep_args.live_grep_args {
               cwd = "~/code/immutable",
               prompt = "~ Immutable platform ~",
               mappings = {
                  i = {
                     ["<C-k>"] = lga_actions.quote_prompt(),
                     ["<C-g>"] = lga_actions.quote_prompt { postfix = " --iglob " },
                  },
               },
               hidden = true,
               layout_strategy = "horizontal",
               layout_config = {
                  preview_width = 0.55,
               },
            }
         end,
      },
   },
   v = {
      ["c"] = { '"_c' }, -- don't yank on change
      ["C"] = { '"_C' }, -- don't yank on change
      ["q"] = { "<nop>" },
      ["<leader>ca"] = { "<cmd>vim.lsp.buf.code_action()<CR>" },
   },

   i = {
      ["<Tab>"] = {
         "v:lua.smart_tab()",
         "Jump to next",
         opts = { expr = true },
      },

      -- Alternative way to save and exit in Normal mode.
      -- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
      ["<C-s>"] = { "<cmd>w<CR><cmd>redraw<CR>" },

      -- -- snippets keybind
      --  I don't think this works
      -- ["<c-k>"] = { "v:lua.snip_complete()" },
      -- ["<c-j>"] = { "v:lua.r_snip_complete()" },
   },
   s = {
      -- -- snippets keybind
      ["<c-k>"] = { "v:lua.snip_complete()" },
      ["<c-j>"] = { "v:lua.r_snip_complete()" },
      ["<c-l>"] = { "<Plug>luansip-next-choice" },
   },
   x = {
      ["n"] = { "'Nn'[v:searchforward]", opts = { expr = true } },
      ["N"] = { "'nN'[v:searchforward]", opts = { expr = true } },
      -- Alternative way to save and exit in Normal mode.
      -- NOTE: Adding `redraw` helps with `cmdheight=0` if buffer is not modified
      ["<C-s>"] = { "<cmd>w<CR><cmd>redraw<CR>" },
   },
   o = {
      ["n"] = { "'Nn'[v:searchforward]", opts = { expr = true } },
      ["N"] = { "'nN'[v:searchforward]", opts = { expr = true } },
   },
}

return M
