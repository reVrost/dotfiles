local M = {}

local userPlugins = require "custom.plugins"

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
         nvim_tree = {
            git = {
               enable = true,
            },
         },
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
