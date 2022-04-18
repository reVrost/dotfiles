local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   lspconfig.tsserver.setup {
      on_attach = function(client, bufnr)
         client.resolved_capabilities.document_formatting = false
         vim.api.nvim_buf_set_keymap(bufnr "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
      end,
   }

   -- lspservers with default config
   local servers = { "clangd", "pyright", "yamlls" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end

   vim.diagnostic.config {
      underline = true,
      virtual_text = true,
   }

   lspconfig.terraformls.setup {
      on_attach = attach,
      capabilities = capabilities,
      filetypes = { "terraform", "hcl" },
      flags = {
         debounce_text_changes = 150,
      },
   }

   lspconfig.gopls.setup {
      on_attach = attach,
      capabilities = capabilities,
      cmd = { "gopls", "serve" },
      settings = {
         gopls = {
            analyses = {
               unusedparams = true,
            },
            staticcheck = true,
            linksInHover = false,
            codelens = {
               generate = true,
               gc_details = true,
               regenerate_cgo = true,
               tidy = true,
               upgrade_depdendency = true,
               vendor = true,
            },
            usePlaceholders = true,
         },
      },
   }
   -- lua lsp!
   lspconfig.sumneko_lua.setup {
      on_attach = attach,
      capabilities = capabilities,
      settings = {
         Lua = {
            diagnostics = {
               globals = { "vim" },
            },
            workspace = {
               library = {
                  [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                  [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
               },
               maxPreload = 100000,
               preloadFileSize = 10000,
            },
         },
      },
   }
end

return M
