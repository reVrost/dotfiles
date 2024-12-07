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

lspconfig.solidity.setup {
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = require("lspconfig.util").find_git_ancestor,
  single_file_support = true,
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
lspconfig.ts_ls.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end,
}

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts), gi is too useful to rebind to lsp
    -- added below for consistency, lets see how useful it is
    vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- lua lsp!
lspconfig.lua_ls.setup {
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
