local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {

   -- webdev stuff
   b.formatting.deno_fmt,
   b.formatting.prettier.with {
      filetypes = {
         "javascript",
         "javascriptreact",
         "typescript",
         "typescriptreact",
         "vue",
         "css",
         "scss",
         "less",
         "html",
         "json",
         "jsonc",
         "markdown",
         "graphql",
         "handlebars",
      },
   },

   -- Protos
   b.diagnostics.buf.with { extra_args = { "--global vim" } },

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
   null_ls.setup {
      debug = true,
      sources = sources,
      -- you can reuse a shared lspconfig on_attach callback here, this is autoformat on save config
      on_attach = function(client)
         if client.resolved_capabilities.document_formatting then
            vim.cmd [[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]]
         end
      end,
   }
end

return M
