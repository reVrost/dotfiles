local lspconfig = require "lspconfig"
local attach = require("plugins.configs.lspconfig").on_attach

local capabilities = require("plugins.configs.lspconfig").capabilities
-- lspservers with default config
local servers = { "clangd", "pyright", "yamlls", "vls" }

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

lspconfig.solc.setup {
   on_attach = attach,
   root_dir = lspconfig.util.root_pattern("hardhat.config.*", ".git"),
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
         codelenses = {
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

-- use null ls for ts format
lspconfig.tsserver.setup {
   on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
   end,
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
