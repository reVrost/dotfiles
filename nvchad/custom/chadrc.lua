local M = {}

local userPlugins = require "custom.plugins"

-- Plugins
M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.lspconfig",
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
      },
      nvim_tree = {
         -- git = {
         --    enable = true,
         -- },
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
   },
}

M.ui = {
   theme = "aquarium",
}

return M
