local M = {}
-- imports
local userPlugins = require "custom.plugins"
local compare = require "cmp.config.compare"
local types = require "cmp.types"

local th = "tokyonight"
local colors = require("hl_themes." .. th)

-- CMP kind wih snippet deprioritized
local kindCompare = function(entry1, entry2)
   local kind1 = entry1:get_kind()
   kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
   local kind2 = entry2:get_kind()
   kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2
   if kind1 ~= kind2 then
      if kind1 == types.lsp.CompletionItemKind.Snippet then
         return false
      end
      if kind2 == types.lsp.CompletionItemKind.Snippet then
         return true
      end
      local diff = kind1 - kind2
      if diff < 0 then
         return true
      elseif diff > 0 then
         return false
      end
   end
end

-- Relative filename on feline
local relative_filename = {
   provider = function()
      local filename = vim.fn.expand "%:~:."
      local extension = vim.fn.expand "%:e"
      local icon = require("nvim-web-devicons").get_icon(filename, extension)
      if icon == nil then
         icon = " "
      end
      return " " .. icon .. " " .. filename .. " "
   end,
   hl = {
      fg = colors.white,
      bg = colors.lightbg,
   },
   right_sep = {
      str = " ",
      hl = { fg = colors.lightbg, bg = colors.lightbg2 },
   },
}

-- Plugins
M.plugins = {
   status = {
      alpha = "true",
   },
   options = {
      lspconfig = {
         setup_lspconf = "custom.lspconfig",
      },
      nvimtree = {
         -- packerCompile required after changing lazy_load
         lazy_load = false,
      },
   },

   default_plugin_config_replace = {
      nvim_treesitter = {
         ensure_installed = {
            "lua",
            "vim",
            "html",
            "css",
            "javascript",
            "typescript",
            "python",
            "json",
            "yaml",
            "markdown",
            "go",
            "bash",
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
      },
      nvim_cmp = {
         sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "nvim_lua" },
            { name = "path" },
            { name = "cmp_tabnine" },
         },
         formatting = {
            format = function(entry, vim_item)
               local icons = require "plugins.configs.lspkind_icons"
               vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

               vim_item.menu = ({
                  nvim_lsp = "[LSP]",
                  nvim_lua = "[Lua]",
                  cmp_tabnine = "[Tabnine]",
                  buffer = "[BUF]",
               })[entry.source.name]

               return vim_item
            end,
         },
         experimental = {
            ghost_text = true,
         },
         sorting = {
            priority_weight = 2,
            comparators = {
               compare.offset,
               compare.exact,
               -- compare.scopes,
               compare.score,
               compare.locality,
               kindCompare,
               compare.recently_used,
               compare.sort_text,
               compare.length,
               compare.order,
            },
         },
      },
      feline = {
         file_name = relative_filename,
      },
      gitsigns = {
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
   install = userPlugins,
}

M.options = {
   relativenumber = true,
}

M.mappings = {
   plugins = {
      better_escape = { -- <ESC> will still work
         esc_insertmode = { "jj", "jk" }, -- multiple mappings allowed
      },
      lspconfig = {
         set_loclist = { "<nop>" },
      },
   },
}

M.ui = {
   theme = th,
   hl_override = "custom.highlights",
}

return M
